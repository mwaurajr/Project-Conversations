# Project Conversations

This Rails application is designed to track project conversations, allowing users to leave comments and change project statuses. The application features a social-media-like interface with comment threading, likes, notifications, and real-time updates.

## Features

- **User Authentication**: Basic authentication using Devise
- **Projects Management**: Create, view, edit, and delete projects
- **Status Changes**: Update project status with tracking of changes
- **Comments System**: 
  - Add comments with optional image attachments
  - Thread comments with replies
  - Like comments
- **Real-time Updates**: Using Turbo Streams for immediate feedback without page refreshes
- **Notifications**: Get notified about comments, likes, and status changes
- **Responsive Design**: Clean, modern UI using Tailwind CSS

## Technical Implementation

### Core Models
- `User`: Authentication and user management
- `Project`: Main project entity
- `Comment`: For conversations, supports nested replies
- `StatusChange`: Records project status transitions
- `Like`: Tracks comment likes
- `Notification`: For user notifications

### Key Technologies
- Ruby on Rails 7
- Hotwire (Turbo Streams) for real-time updates
- Stimulus.js for frontend interactivity
- Tailwind CSS for styling
- Active Storage for image attachments
- PostgreSQL database

## Setup Instructions

1. Clone the repository
2. Install dependencies:
   ```
   bundle install
   yarn install
   ```
3. Setup the database:
   ```
   rails db:create
   rails db:migrate
   ```
4. Start the server:
   ```
   bin/dev
   ```

## Design Decisions

- **Threaded Comments**: Implemented with a self-referential association to allow for nested discussions
- **Turbo Streams**: Used for real-time updates to provide a more interactive experience
- **Status Tracking**: Status changes are stored as separate entities to maintain a history of project progression
- **Notifications**: Implemented to keep users informed about activities related to their projects
- **Image Attachments**: Added to enhance the commenting experience

## Future Enhancements

- **User Mentions**: Implement @mentions in comments
- **Advanced Search**: Add search capabilities across projects and comments
- **User Roles**: Implement different permission levels
- **Email Notifications**: Send email notifications for important events
- **Project Categories**: Add categorization for better organization
