# Use an official Ruby runtime as a parent image
FROM ruby:3.2

# Set environment variables
ENV RAILS_ENV=production \
    RACK_ENV=production \
    NODE_ENV=production

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /app

# Install Yarn (for managing JavaScript dependencies)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Install Bundler
RUN gem install bundler -v '2.4.20'

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --without development test

# Copy the entire application code to the working directory
COPY . .

# Ensure the Rakefile exists
RUN if [ ! -f "Rakefile" ]; then echo "Rakefile not found in the expected location"; exit 1; fi

# Precompile assets
# RUN bundle exec rake assets:precompile
# Ensure the Rails environment is set before precompiling assets
RUN bundle exec rails assets:precompile
# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
