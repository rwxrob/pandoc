FROM debian
USER root
RUN apt update -y && apt install -y curl vim && \
  loc=$(curl -o /dev/null -sIw "%{redirect_url}" \
        'https://github.com/jgm/pandoc/releases/latest') && \
	vers=${loc##*/} && \
  deb="pandoc-$vers-1-amd64.deb" && \
  uri=${loc%/tag*}/download/$vers/$deb && \
  curl -sL "$uri" -o "/tmp/$deb" && \
	dpkg -i "/tmp/$deb"
COPY Dockerfile entrypoint /
ENTRYPOINT ["sh","/entrypoint"]
