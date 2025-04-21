# Drag and Drop Kanban Board

A simple Kanban board with drag and drop functionality built with Ruby on Rails.

🔗 **Live Demo**: [https://kanban.koesterjannik.com](https://kanban.koesterjannik.com)

## Features

- Drag and drop cards between columns
- Assign cards to users
- Invite other users for collaboration
- Email notifications when cards are assigned

## How to run locally


1. Install dependencies:
   ```bash
   bundle install
   ```
2. Copy and paste the .env.example file to .env and set the variables. We are using SES for emails

2. Set up the database:
   ```bash
   rails db:migrate
   ```

3. Start the server:
   ```bash
   bin/dev
   ```

## License

This project is licensed under the MIT License.
