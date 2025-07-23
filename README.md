# 📈 Habit Tracker - Rails 7 Application

A Rails 7 app to help users track their habits with daily check-ins, streaks, consistency metrics, and a Tailwind CSS-powered UI.

---

## 🧱 Tech Stack

- **Ruby**: 3.1.0p0  
- **Rails**: 7.2.2.1  
- **Database**: PostgreSQL  
- **Background Jobs**: Sidekiq + sidekiq-scheduler  
- **UI**: Tailwind CSS  
- **Real-time**: Hotwire (Turbo + Stimulus)  
- **Job Queue**: Redis  

---

## 🚀 Quick Setup

```bash
# Clone the repository
git clone https://github.com/ror-deve/consistently-habit-tracker.git
cd consistently-habit-tracker

# Install dependencies
bundle install
yarn install --check-files

# Set up the database
rails db:create db:migrate db:seed

# Build frontend assets
yarn build

# Start Redis (open a new terminal if needed)
redis-server &

# Start Sidekiq
bundle exec sidekiq -C config/sidekiq.yml &

# Start the Rails server
rails server

# Open your browser at: http://localhost:3000
