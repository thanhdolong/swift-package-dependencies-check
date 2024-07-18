# Update the base image to Swift 6.0 if available
FROM swiftlang/swift:nightly-jammy

# Repository and branch for release notes
ARG SWIFT_RELEASENOTES_REPOSITORY="https://github.com/SwiftPackageIndex/ReleaseNotes.git"
ARG SWIFT_RELEASENOTES_BRANCH="main"

# Metadata
LABEL Description="Docker Container for GitHub action swift-package-dependencies-check"
LABEL repository="http://github.com/thanhdolong/swift-package-dependencies-check/edit/main/Dockerfile"
LABEL maintainer="Do Long Thanh <thanh.dolong@gmail.com>"

# Clone the repository and install dependencies
RUN git clone -b $SWIFT_RELEASENOTES_BRANCH $SWIFT_RELEASENOTES_REPOSITORY _swift-release-notes \
    && cd _swift-release-notes \
    && git checkout main \
    && apt-get update \
    && apt-get install -y make \
    && make install

# Add the entrypoint script and make it executable
ADD entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

# Set the entrypoint for the container
ENTRYPOINT ["entrypoint"]
