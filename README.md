# signup_app

A new Flutter project.

## Getting Started

Cassie Nguyen

I did Task A: AI Signup Coach

Questions:

1. Trace the AI tip feature from button tap to displayed text. Which widget/state changes while the request is waiting, and how does the user recover if it fails?

When the user clicks the "Get a signup tip" button, it sets _loadingTip to true and shows the loading indicator while waiting for the tip. Once it gets the tip, it displays it as text, but if something goes wrong, it shows an error message and lets the user retry.

2. Why must the app keep form validation local even when it can ask an AI for a tip? Give one example of a bad decision if AI were allowed to approve signup.

I think form validation should stay local because the AI tip is just advice and shouldn't decide if the user's information is valid or not. Like the AI could say a password is good enough even if it is only 3 characters long, which would go against the actual password rules we made for the form.