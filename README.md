# Kraken

```bash
# Setup database
bundle exec rails db:setup

# Start a develoment tmux session
./scripts/start-development-tmux.sh
```

## Docker

```bash
# Build docker images
docker-compose build

# Run development docker
docker-compose run --service-ports kraken
```
