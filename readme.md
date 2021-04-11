## Hello there 👋 🤖

This is a rails app which uses Rake to fetch and post exchange rate fluctuations on USD against CRC (Costa Rican Colon).
It leverages some active record modelling, some API client implementation and Event Dispatch/Subscribe to do so. Have a looksie

```ruby
bundle exe rake exchange_rate:kick
```

Powered by Heroku ([link](https://bac-app.herokuapp.com/))
