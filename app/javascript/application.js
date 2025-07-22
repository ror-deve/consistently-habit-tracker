// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "./controllers"
import { Application } from "@hotwired/stimulus";
const application = Application.start();
window.Stimulus = application;

import Rails from "@rails/ujs";

window.Rails = Rails;
Rails.start();

import "./controllers";
