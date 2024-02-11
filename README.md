# The Comics Test  - Marvel Comics API

## Description

This is a single-page web app that fetches a random story from the Marvel Comics universe featuring the character Sunspot. Upon loading the page, you can expect to see a story's name and description, if available, along with name and image of the characters involved. If a story lacks a description, the app displays "No description available."

Every time the page is load/reload, a request to the Marvel API is made, fetching a random story in which Sunspot is present.

I picked [Sunspot](https://www.marvel.com/characters/sunspot) as my favorite character since the identification is evident: Brazilian, from Rio de Janeiro, dreamed of being a football player and has a girlfriend named Juliana 🙃.

## Prerequisites

Before running the application, ensure you have the following installed:

- Ruby 3.1.2
- Bundler

## Basic Setup

1. Clone the repository to your local machine:

   ```bash
   git clone git@github.com:pbragamiranda/the-comics-test.git
   ```

2. Navigate to the project directory:

   ```bash
   cd the-comics-test
   ```

3. Create a `.env` file in the project root and add your Marvel API public and private keys:

   ```bash
   touch .env
   ```


   ```plaintext
   # .env
MARVEL_PUBLIC_KEY=your-public-key
MARVEL_PRIVATE_KEY=your-private-key
```

   You can find your Marvel API keys by signing up for an account on the [Marvel Developer Portal](https://developer.marvel.com/account).

4. Install dependencies using Bundler:

   ```bash
   bundle install
   ```

## Running the app

To start the server, you can run:

```bash
ruby app.rb
```

Once the server is running, you can access the application by navigating to `http://localhost:4567` in your web browser.

As mentioned before, every time the page is load/reload, a request to the Marvel API is made, fetching a random story in which Sunspot is present.

## Running Tests

To run the tests, execute the following command:

```bash
bundle exec rspec
```
