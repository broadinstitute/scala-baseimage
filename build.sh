#!/usr/bin/env bash

# Builds pair a scala version with an sbt version
SCALA_VERSIONS=(  2.12.11   2.12.12   2.12.12   2.12.12   2.12.13   2.12.13   2.13.5)
SBT_VERSIONS=(    1.4.7     1.4.6     1.4.7     1.4.9     1.4.7     1.4.9     1.4.7)

# $((x - 1)) is needed because otherwise it actually outputs length, but we need to be zero-indexed
for i in $(seq 0 $((${#SCALA_VERSIONS[@]} - 1))); do
  IMAGE_NAME="broadinstitute/scala-baseimage:jdk11-${SCALA_VERSIONS[i]}-${SBT_VERSIONS[i]}"

  docker build \
    --build-arg SCALA_VERSION="${SCALA_VERSIONS[i]}" \
    --build-arg SBT_VERSION="${SBT_VERSIONS[i]}" \
    -t "$IMAGE_NAME" \
    .

  docker push "$IMAGE_NAME"
done
