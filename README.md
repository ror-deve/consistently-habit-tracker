# 📈 Habit Tracker Rails Application

A Rails 7 app to help users track habits with authentication, check-ins, streak tracking, and a Tailwind CSS-powered responsive UI.

---

## 🧱 Tech Stack

- **Ruby:** 3.1.0p0
- **Rails:** 7.2.2.1
- **Database:** PostgreSQL
- **Background Jobs:** Sidekiq + sidekiq-scheduler
- **UI:** Tailwind CSS
- **Real-time:** Hotwire (Turbo + Stimulus)
- **Job Queue:** Redis

---

## 🚀 Quick Setup
git clone https://github.com/ror-deve/consistently-habit-tracker.git
cd consistently-habit-tracker
bundle install
yarn install --check-files
rails db:create db:migrate db:seed
yarn build
redis-server &    # Start Redis in background (or open a new terminal window)
bundle exec sidekiq -C config/sidekiq.yml &
rails server

Then open your browser at http://localhost:3000