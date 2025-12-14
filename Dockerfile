FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        coreutils \
        sed \
        grep \
        gawk && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY scripts/ scripts/
COPY data/raw/ data/raw/

RUN chmod +x scripts/process_data.sh

CMD ["bash", "scripts/process_data.sh"]
