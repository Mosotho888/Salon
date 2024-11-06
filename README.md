# My Salon Appointment Scheduler

A bash-based appointment scheduling system for managing salon bookings. This program allows customers to view available services, select a service, enter their details, and schedule appointments.

## Features

- **Service Listing**: Displays available salon services.
- **Customer Information**: Collects customer phone number and name.
- **Appointment Scheduling**: Allows customers to book an appointment and confirms the booking details.

## Prerequisites

- **PostgreSQL**: Ensure PostgreSQL is installed and running.
- **Database and User**: You need a database named `salon` and a user named `freecodecamp` with necessary permissions.

## Database Setup

1. Run the provided SQL setup file (`salon.sql`) to create the required tables and populate the `services` table with initial data.
   ```bash
   psql -U <username> -d salon -f salon.sql
2. Confirm the database includes these tables:
- **services**: Stores each service's details (`service_id`, `name`).
- **customers**: Stores customer information (`customer_id`, `name`, `phone`).
- **appointments**: Stores appointment details (`appointment_id`, `customer_id`, `service_id`, `time`).

## Usage

1. **Clone the repository** and navigate to the script’s directory.

2. Ensure the `salon.sh` script has executable permissions:
   ```bash
   chmod +x salon.sh
3. Run the script:
  ```bash
 ./salon.sh
4. Follow the on-screen prompts to:
- Select a service.
- Provide customer information.
- Choose a preferred appointment time.
- The system confirms each booking and displays the scheduled appointment details.

## Script Overview

1. Functions
-**MAIN_MENU**: Lists all available services from the services table and manages invalid selections.
-**PICK_A_SERVICE**: Manages service selection, collects customer contact information, and schedules the appointment.

## Example Interaction

~~~~ My Salon ~~~~

Welcome to my salon, how can I help you?

1) Haircut
2) Manicure
3) Pedicure

Please select a service:
> 1

What's your number?
> 123-456-7890

I don't have a record for that phone number, what's your name?
> Tebogo

What time would you like your Haircut, Tebogo?
> 2:00 PM

I have put you down for a Haircut at 2:00 PM, Jane Doe.
