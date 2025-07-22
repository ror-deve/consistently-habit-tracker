# 📈 Habit Tracker Rails Application

A Rails 7 app to help users track habits with authentication, check-ins, streak tracking, and a Tailwind CSS-powered responsive UI.

---

## 🧱 Tech Stack

- **Ruby:** 3.1.0p0
- **Rails:** 7.2.2.1
- **Node.js:** v18.20.8
- **Yarn:** 1.22.22
- **Database:** PostgreSQL
- **Background Jobs:** Sidekiq + sidekiq-scheduler
- **UI:** Tailwind CSS
- **Real-time:** Hotwire (Turbo + Stimulus)
- **Job Queue:** Redis

---

## 🚀 Setup

```bash
git clone https://github.com/ror-deve/consistently-habit-tracker.git
cd consistently-habit-tracker
bundle install
yarn install --check-files
rails db:create db:migrate db:seed


# Start Redis & background workers:
redis-server
bundle exec sidekiq -C config/sidekiq.yml

# Run the server:
rails server
# App: http://localhost:3000

# Tailwind CSS
# Hotwire and stimulus