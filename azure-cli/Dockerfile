FROM microsoft/azure-cli:2.0.54

LABEL version="1.0.0"
LABEL repository="http://github.com/actions/azure"
LABEL homepage="http://github.com/actions/azure"

LABEL maintainer="tomakabe@microsoft.com>"
LABEL com.github.actions.name="GitHub Action for Azure"
LABEL com.github.actions.description="Wraps the az CLI to enable common Azure commands."
LABEL com.github.actions.icon="triangle"
LABEL com.github.actions.color="blue"

RUN az extension add --name webapp \
    && apk update \
    && (apk info | xargs -n1 -I{} apk --quiet add {}-doc); true \
    && rm -rf /var/cache/apk/*

COPY --from=docker:stable /usr/local/bin/docker /usr/local/bin

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "help" ]