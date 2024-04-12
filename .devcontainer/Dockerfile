FROM ruby:slim

ENV RUBY_YJIT_ENABLE=1

RUN apt update && \
    apt install -y cmake curl fd-find git gnupg libpoppler-glib8 libpq-dev libvips42 libyaml-dev pkg-config ripgrep watchman && \
    apt clean

ENTRYPOINT ["/bin/bash", "--login", "-c"]

CMD "bash"
