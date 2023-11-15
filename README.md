# Course Gate

Course Gate is a web application that allows students to enroll in courses and instructors to manage course offerings.

## Features

- Students can browse available courses and enroll in them.
- Instructors can create, edit, and delete courses.
- Authentication system for students and instructors.
- Enrollment validation to prevent duplicate enrollments.
- User-friendly interface for easy navigation.

## Technologies Used

- Ruby on Rails: A web development framework used for building the application.
- PostgreSQL: The database management system for storing application data.
- Tailwind: A front-end framework for responsive and attractive user interface design.
- Stimulus: a rails-like integration of javascript code into the frontend.

## Getting Started

### Prerequisites

- Ruby (version 3.1.3)
- Ruby on Rails (version 7.0.4)
- PostgreSQL (version 10 or higher)

### Installation

1. Clone the repository:

   ```shell
   git clone https://github.com/your-username/course-gate.git
   ```
2. Navigate to the project directory:
   
   ```shell
   cd course-gate
   ```
   
   
3. Install dependencies:

    ```shell
    bundle install
    ```

4. Create and migrate the database:
    ```shell
    rails db:create
    rails db:migrate
    ```

5. Start the server:
    ```shell
    rails server
    ```

6. Open your web browser and access the application at `http://localhost:3000`.

## Contributing

Contributions to Course Gate are welcome! If you find any issues or have suggestions for improvements, please create a new issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
