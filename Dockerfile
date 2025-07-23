# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development.
# Use with Kamal or build'n'run manually:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

ARG RUBY_VERSION=3.1.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app working directory
WORKDIR /rails

# Install base packages required for app runtime
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables for production bundler config
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Build stage to install dependencies and precompile assets
FROM base AS build

# Install packages needed to build gems and compile native extensions
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Node.js and Yarn for JS dependencies and asset building
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Copy Gemfile and lockfile, install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set frozen false && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application source code
COPY . .

# Install JS dependencies and build assets (Tailwind, Stimulus, etc.)
RUN yarn install
RUN yarn build

# Precompile bootsnap cache to speed app boot
RUN bundle exec bootsnap precompile app/ lib/

# Precompile Rails assets (with dummy secret key for production)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage - minimal production image
FROM base

# Copy gems and app code from build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create non-root user to run app for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Entrypoint to prepare database etc.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose default Rails port
EXPOSE 3000

# Start the Rails server by default
CMD ["./bin/rails", "server"]
