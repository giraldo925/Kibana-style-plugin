FROM alpine:3.7 as builder
COPY kibana /kibana
RUN apk add --no-cache zip
RUN zip -r /gradiant_style.zip kibana

FROM docker.elastic.co/kibana/kibana-oss:6.4.1
MAINTAINER cgiraldo@gradiant.org
# custom favicons
COPY favicons/* /usr/share/kibana/src/ui/public/assets/favicons/
# custom throbber
RUN sed -i 's/Kibana/Gradiant-Analytics/g' /usr/share/kibana/src/core_plugins/kibana/translations/en.json
RUN sed -i 's/image\/svg+xml.*");/image\/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM6c29kaXBvZGk9Imh0dHA6Ly9zb2RpcG9kaS5zb3VyY2Vmb3JnZS5uZXQvRFREL3NvZGlwb2RpLTAuZHRkIgogICB4bWxuczppbmtzY2FwZT0iaHR0cDovL3d3dy5pbmtzY2FwZS5vcmcvbmFtZXNwYWNlcy9pbmtzY2FwZSIKICAgaGVpZ2h0PSI1MSIKICAgd2lkdGg9IjE1MCIKICAgdmVyc2lvbj0iMS4xIgogICBpZD0iTGF5ZXJfMSIKICAgeD0iMHB4IgogICB5PSIwcHgiCiAgIHZpZXdCb3g9IjAgMCAxNTAuMDAwMDEgNTEiCiAgIHhtbDpzcGFjZT0icHJlc2VydmUiCiAgIHNvZGlwb2RpOmRvY25hbWU9ImxvZ28uc3ZnIgogICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjkyLjMgKGQyNDRiOTUsIDIwMTgtMDgtMDIpIj48c29kaXBvZGk6bmFtZWR2aWV3CiAgIHBhZ2Vjb2xvcj0iI2ZmZmZmZiIKICAgYm9yZGVyY29sb3I9IiM2NjY2NjYiCiAgIGJvcmRlcm9wYWNpdHk9IjEiCiAgIG9iamVjdHRvbGVyYW5jZT0iMTAiCiAgIGdyaWR0b2xlcmFuY2U9IjEwIgogICBndWlkZXRvbGVyYW5jZT0iMTAiCiAgIGlua3NjYXBlOnBhZ2VvcGFjaXR5PSIwIgogICBpbmtzY2FwZTpwYWdlc2hhZG93PSIyIgogICBpbmtzY2FwZTp3aW5kb3ctd2lkdGg9IjY0MCIKICAgaW5rc2NhcGU6d2luZG93LWhlaWdodD0iNDgwIgogICBpZD0ibmFtZWR2aWV3MTAiCiAgIHNob3dncmlkPSJmYWxzZSIKICAgaW5rc2NhcGU6em9vbT0iMy4wNCIKICAgaW5rc2NhcGU6Y3g9Ijc1IgogICBpbmtzY2FwZTpjeT0iMjUuNSIKICAgaW5rc2NhcGU6d2luZG93LXg9Ijg2MyIKICAgaW5rc2NhcGU6d2luZG93LXk9IjIxMiIKICAgaW5rc2NhcGU6d2luZG93LW1heGltaXplZD0iMCIKICAgaW5rc2NhcGU6Y3VycmVudC1sYXllcj0iTGF5ZXJfMSIgLz48bWV0YWRhdGEKICAgaWQ9Im1ldGFkYXRhMzgiPjxyZGY6UkRGPjxjYzpXb3JrCiAgICAgICByZGY6YWJvdXQ9IiI+PGRjOmZvcm1hdD5pbWFnZS9zdmcreG1sPC9kYzpmb3JtYXQ+PGRjOnR5cGUKICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8vcHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz48ZGM6dGl0bGU+S2liYW5hLUZ1bGwtTG9nbzwvZGM6dGl0bGU+PC9jYzpXb3JrPjwvcmRmOlJERj48L21ldGFkYXRhPjxkZWZzCiAgIGlkPSJkZWZzMzYiIC8+PHN0eWxlCiAgIHR5cGU9InRleHQvY3NzIgogICBpZD0ic3R5bGUzIj4KCS5zdDB7ZmlsbDojRkZGRkZGO2ZpbGwtb3BhY2l0eTowLjkyNTM7fQoJLnN0MXtvcGFjaXR5OjAuNztmaWxsOiNGRkZGRkY7fQoJLnN0MntvcGFjaXR5OjAuNTtmaWxsOiNGRkZGRkY7fQoJLnN0M3tmaWxsOiNGRkZGRkY7fQo8L3N0eWxlPjx0aXRsZQogICBpZD0idGl0bGU3Ij5LaWJhbmEtRnVsbC1Mb2dvPC90aXRsZT48cGF0aAogICBjbGFzcz0iY2xzLTEiCiAgIGQ9Im0gMzguNzQ3MDAyLDMyLjQ4NDk4IGMgLTUuNzgzMzk1LC0zLjc2OTU5OSAtMTUuOTk1NzEsMy42NDA2IC0xOS4zOTI2NDgsNS44MjYzOTMgLTUuNjkwMjI5LDMuNjYyMTAxIC0xNC44MjAzOTY1LDYuMzM1MjIgLTE5LjUzNTk3NzYsMC41OTQ4MjMgQyA3LjU0MzkwMjgsMzkuNTAxMDIgNy42Mjk5MDA5LDMwLjA5MTM1NyA3LjQ3OTQwMzksMjQuODc0MTE4IDcuMjkzMDc0MiwxOC40MjQyMzUgOC4xOTYwNTgsMTIuNjQ4MDA3IDEzLjQyMDQ2Miw4LjQ2Mjc0OTIgMTMuMDI2MzA0LDExLjE2NDUzNCAxMi40OTU5NzksMTMuNzUxNjUzIDE1LjAxODYsMTYuNzE4NiBjIDIuMTQ5OTYxLDIuNTA4Mjg3IDUuNTExMDY3LDMuODc3MDk1IDguNjM1Njc1LDQuNjUxMDgyIDYuMjM0ODg4LDEuNTMzNjM4IDEyLjk5MjkzMiw0LjIzNTQyMiAxNS4wOTI3MjcsMTEuMTE1Mjk4IgogICBpZD0icGF0aDkiCiAgIHN0eWxlPSJmaWxsOiNlYjIwMjY7ZmlsbC1vcGFjaXR5OjEiIC8+PGcKICAgYXJpYS1sYWJlbD0iZ3JhZGlhbnQiCiAgIHN0eWxlPSJmb250LXN0eWxlOm5vcm1hbDtmb250LXZhcmlhbnQ6bm9ybWFsO2ZvbnQtd2VpZ2h0OjYwMDtmb250LXN0cmV0Y2g6bm9ybWFsO2ZvbnQtc2l6ZTo0MHB4O2xpbmUtaGVpZ2h0OjEyNSU7Zm9udC1mYW1pbHk6TW9udHNlcnJhdDstaW5rc2NhcGUtZm9udC1zcGVjaWZpY2F0aW9uOidNb250c2VycmF0IFNlbWktQm9sZCc7bGV0dGVyLXNwYWNpbmc6MHB4O3dvcmQtc3BhY2luZzowcHg7ZmlsbDojMDAwMDAwO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTpub25lO3N0cm9rZS13aWR0aDoxcHg7c3Ryb2tlLWxpbmVjYXA6YnV0dDtzdHJva2UtbGluZWpvaW46bWl0ZXI7c3Ryb2tlLW9wYWNpdHk6MSIKICAgaWQ9InRleHQ0MTU2IgogICB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNCkiPjxwYXRoCiAgICAgZD0ibSA2MS4yNzE1ODQsMjguMTMzOTQyIHEgMCwtMi40NDE0MDcgLTEuMDEzMTg0LC0zLjc4NDE4IC0xLjAwMDk3NywtMS4zNDI3NzMgLTIuODE5ODI0LC0xLjM0Mjc3MyAtMS44MDY2NDEsMCAtMi44MTk4MjQsMS4zNDI3NzMgLTEuMDAwOTc3LDEuMzQyNzczIC0xLjAwMDk3NywzLjc4NDE4IDAsMi40MjkxOTkgMS4wMDA5NzcsMy43NzE5NzIgMS4wMTMxODMsMS4zNDI3NzQgMi44MTk4MjQsMS4zNDI3NzQgMS44MTg4NDcsMCAyLjgxOTgyNCwtMS4zNDI3NzQgMS4wMTMxODQsLTEuMzQyNzczIDEuMDEzMTg0LC0zLjc3MTk3MiB6IG0gMi4yNDYwOTMsNS4yOTc4NTEgcSAwLDMuNDkxMjExIC0xLjU1MDI5Myw1LjE4Nzk4OCAtMS41NTAyOTMsMS43MDg5ODUgLTQuNzQ4NTM1LDEuNzA4OTg1IC0xLjE4NDA4MiwwIC0yLjIzMzg4NywtMC4xODMxMDYgLTEuMDQ5ODA0LC0wLjE3MDg5OCAtMi4wMzg1NzQsLTAuNTM3MTA5IHYgLTIuMTg1MDU5IHEgMC45ODg3NywwLjUzNzExIDEuOTUzMTI1LDAuNzkzNDU3IDAuOTY0MzU2LDAuMjU2MzQ4IDEuOTY1MzMyLDAuMjU2MzQ4IDIuMjA5NDczLDAgMy4zMDgxMDYsLTEuMTU5NjY4IDEuMDk4NjMzLC0xLjE0NzQ2MSAxLjA5ODYzMywtMy40NzkwMDQgdiAtMS4xMTA4NCBxIC0wLjY5NTgwMSwxLjIwODQ5NiAtMS43ODIyMjcsMS44MDY2NDEgLTEuMDg2NDI2LDAuNTk4MTQ1IC0yLjYwMDA5OCwwLjU5ODE0NSAtMi41MTQ2NDgsMCAtNC4wNTI3MzQsLTEuOTE2NTA0IC0xLjUzODA4NiwtMS45MTY1MDQgLTEuNTM4MDg2LC01LjA3ODEyNSAwLC0zLjE3MzgyOCAxLjUzODA4NiwtNS4wOTAzMzIgMS41MzgwODYsLTEuOTE2NTA0IDQuMDUyNzM0LC0xLjkxNjUwNCAxLjUxMzY3MiwwIDIuNjAwMDk4LDAuNTk4MTQ0IDEuMDg2NDI2LDAuNTk4MTQ1IDEuNzgyMjI3LDEuODA2NjQxIHYgLTIuMDc1MTk1IGggMi4yNDYwOTMgeiIKICAgICBzdHlsZT0iZm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDo1MDA7Zm9udC1zdHJldGNoOm5vcm1hbDtmb250LXNpemU6MjVweDtmb250LWZhbWlseTpNb250c2VycmF0Oy1pbmtzY2FwZS1mb250LXNwZWNpZmljYXRpb246J01vbnRzZXJyYXQgTWVkaXVtJztsZXR0ZXItc3BhY2luZzotMS4yMzAwMDAwMnB4IgogICAgIGlkPSJwYXRoMzcxNSIKICAgICBpbmtzY2FwZTpjb25uZWN0b3ItY3VydmF0dXJlPSIwIiAvPjxwYXRoCiAgICAgZD0ibSA3NC44MzY1MDYsMjMuNTU2MzA1IHEgLTAuMzc4NDE4LC0wLjIxOTcyNyAtMC44MzAwNzgsLTAuMzE3MzgzIC0wLjQzOTQ1MywtMC4xMDk4NjMgLTAuOTc2NTYzLC0wLjEwOTg2MyAtMS45MDQyOTcsMCAtMi45Mjk2ODcsMS4yNDUxMTcgLTEuMDEzMTg0LDEuMjMyOTEgLTEuMDEzMTg0LDMuNTUyMjQ2IHYgNy4yMDIxNDkgSCA2Ni44Mjg2OTMgViAyMS40NTY2OTYgaCAyLjI1ODMwMSB2IDIuMTI0MDIzIHEgMC43MDgwMDgsLTEuMjQ1MTE3IDEuODQzMjYyLC0xLjg0MzI2MiAxLjEzNTI1NCwtMC42MTAzNTEgMi43NTg3ODksLTAuNjEwMzUxIDAuMjMxOTM0LDAgMC41MTI2OTUsMC4wMzY2MiAwLjI4MDc2MiwwLjAyNDQxIDAuNjIyNTU5LDAuMDg1NDUgeiIKICAgICBzdHlsZT0iZm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDo1MDA7Zm9udC1zdHJldGNoOm5vcm1hbDtmb250LXNpemU6MjVweDtmb250LWZhbWlseTpNb250c2VycmF0Oy1pbmtzY2FwZS1mb250LXNwZWNpZmljYXRpb246J01vbnRzZXJyYXQgTWVkaXVtJztsZXR0ZXItc3BhY2luZzotMS4yMzAwMDAwMnB4IgogICAgIGlkPSJwYXRoMzcxNyIKICAgICBpbmtzY2FwZTpjb25uZWN0b3ItY3VydmF0dXJlPSIwIiAvPjxwYXRoCiAgICAgZD0ibSA4Mi4yMDAyNTYsMjguMjU2MDEyIHEgLTIuNzIyMTY4LDAgLTMuNzcxOTcyLDAuNjIyNTU5IC0xLjA0OTgwNSwwLjYyMjU1OCAtMS4wNDk4MDUsMi4xMjQwMjMgMCwxLjE5NjI4OSAwLjc4MTI1LDEuOTA0Mjk3IDAuNzkzNDU3LDAuNjk1ODAxIDIuMTQ4NDM4LDAuNjk1ODAxIDEuODY3Njc1LDAgMi45OTA3MjIsLTEuMzE4MzYgMS4xMzUyNTQsLTEuMzMwNTY2IDEuMTM1MjU0LC0zLjUyNzgzMiB2IC0wLjUwMDQ4OCB6IG0gNC40Nzk5ODEsLTAuOTI3NzM0IHYgNy44MDAyOTMgaCAtMi4yNDYwOTQgdiAtMi4wNzUxOTYgcSAtMC43NjkwNDMsMS4yNDUxMTcgLTEuOTE2NTA0LDEuODQzMjYyIC0xLjE0NzQ2MSwwLjU4NTkzNyAtMi44MDc2MTcsMC41ODU5MzcgLTIuMDk5NjA5LDAgLTMuMzQ0NzI3LC0xLjE3MTg3NSAtMS4yMzI5MSwtMS4xODQwODIgLTEuMjMyOTEsLTMuMTYxNjIxIDAsLTIuMzA3MTI5IDEuNTM4MDg2LC0zLjQ3OTAwNCAxLjU1MDI5MywtMS4xNzE4NzUgNC42MTQyNTgsLTEuMTcxODc1IGggMy4xNDk0MTQgdiAtMC4yMTk3MjYgcSAwLC0xLjU1MDI5MyAtMS4wMjUzOTEsLTIuMzkyNTc4IC0xLjAxMzE4MywtMC44NTQ0OTIgLTIuODU2NDQ1LC0wLjg1NDQ5MiAtMS4xNzE4NzUsMCAtMi4yODI3MTUsMC4yODA3NjEgLTEuMTEwODQsMC4yODA3NjIgLTIuMTM2MjMsMC44NDIyODUgdiAtMi4wNzUxOTUgcSAxLjIzMjkxLC0wLjQ3NjA3NCAyLjM5MjU3OCwtMC43MDgwMDggMS4xNTk2NjgsLTAuMjQ0MTQgMi4yNTgzMDEsLTAuMjQ0MTQgMi45NjYzMDgsMCA0LjQzMTE1MiwxLjUzODA4NiAxLjQ2NDg0NCwxLjUzODA4NiAxLjQ2NDg0NCw0LjY2MzA4NiB6IgogICAgIHN0eWxlPSJmb250LXN0eWxlOm5vcm1hbDtmb250LXZhcmlhbnQ6bm9ybWFsO2ZvbnQtd2VpZ2h0OjUwMDtmb250LXN0cmV0Y2g6bm9ybWFsO2ZvbnQtc2l6ZToyNXB4O2ZvbnQtZmFtaWx5Ok1vbnRzZXJyYXQ7LWlua3NjYXBlLWZvbnQtc3BlY2lmaWNhdGlvbjonTW9udHNlcnJhdCBNZWRpdW0nO2xldHRlci1zcGFjaW5nOi0xLjIzMDAwMDAycHgiCiAgICAgaWQ9InBhdGgzNzE5IgogICAgIGlua3NjYXBlOmNvbm5lY3Rvci1jdXJ2YXR1cmU9IjAiIC8+PHBhdGgKICAgICBkPSJNIDk5LjA4NTQ5MSwyMy41MzE4OTEgViAxNi4xMzQ0MyBoIDIuMjQ2MDg5IHYgMTguOTk0MTQxIGggLTIuMjQ2MDg5IHYgLTIuMDUwNzgyIHEgLTAuNzA4MDA4LDEuMjIwNzAzIC0xLjc5NDQzMywxLjgxODg0OCAtMS4wNzQyMTksMC41ODU5MzcgLTIuNTg3ODkxLDAuNTg1OTM3IC0yLjQ3ODAyNywwIC00LjA0MDUyNywtMS45Nzc1MzkgLTEuNTUwMjkzLC0xLjk3NzUzOSAtMS41NTAyOTMsLTUuMjAwMTk1IDAsLTMuMjIyNjU2IDEuNTUwMjkzLC01LjIwMDE5NSAxLjU2MjUsLTEuOTc3NTM5IDQuMDQwNTI3LC0xLjk3NzUzOSAxLjUxMzY3MiwwIDIuNTg3ODkxLDAuNTk4MTQ0IDEuMDg2NDI1LDAuNTg1OTM4IDEuNzk0NDMzLDEuODA2NjQxIHogbSAtNy42NTM4MDgsNC43NzI5NDkgcSAwLDIuNDc4MDI3IDEuMDEzMTgzLDMuODk0MDQzIDEuMDI1MzkxLDEuNDAzODA5IDIuODA3NjE3LDEuNDAzODA5IDEuNzgyMjI3LDAgMi44MDc2MTgsLTEuNDAzODA5IDEuMDI1MzksLTEuNDE2MDE2IDEuMDI1MzksLTMuODk0MDQzIDAsLTIuNDc4MDI3IC0xLjAyNTM5LC0zLjg4MTgzNiAtMS4wMjUzOTEsLTEuNDE2MDE1IC0yLjgwNzYxOCwtMS40MTYwMTUgLTEuNzgyMjI2LDAgLTIuODA3NjE3LDEuNDE2MDE1IC0xLjAxMzE4MywxLjQwMzgwOSAtMS4wMTMxODMsMy44ODE4MzYgeiIKICAgICBzdHlsZT0iZm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDo1MDA7Zm9udC1zdHJldGNoOm5vcm1hbDtmb250LXNpemU6MjVweDtmb250LWZhbWlseTpNb250c2VycmF0Oy1pbmtzY2FwZS1mb250LXNwZWNpZmljYXRpb246J01vbnRzZXJyYXQgTWVkaXVtJztsZXR0ZXItc3BhY2luZzotMS4yMzAwMDAwMnB4IgogICAgIGlkPSJwYXRoMzcyMSIKICAgICBpbmtzY2FwZTpjb25uZWN0b3ItY3VydmF0dXJlPSIwIiAvPjxwYXRoCiAgICAgZD0ibSAxMDQuNzI4MDUsMjEuNDU2Njk2IGggMi4yNDYwOSB2IDEzLjY3MTg3NSBoIC0yLjI0NjA5IHogbSAwLC01LjMyMjI2NiBoIDIuMjQ2MDkgdiAyLjg0NDIzOCBoIC0yLjI0NjA5IHoiCiAgICAgc3R5bGU9ImZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtdmFyaWFudDpub3JtYWw7Zm9udC13ZWlnaHQ6NTAwO2ZvbnQtc3RyZXRjaDpub3JtYWw7Zm9udC1zaXplOjI1cHg7Zm9udC1mYW1pbHk6TW9udHNlcnJhdDstaW5rc2NhcGUtZm9udC1zcGVjaWZpY2F0aW9uOidNb250c2VycmF0IE1lZGl1bSc7bGV0dGVyLXNwYWNpbmc6LTEuMjMwMDAwMDJweCIKICAgICBpZD0icGF0aDM3MjMiCiAgICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz48cGF0aAogICAgIGQ9Im0gMTE2LjY0NTAyLDI4LjI1NjAxMiBxIC0yLjcyMjE3LDAgLTMuNzcxOTcsMC42MjI1NTkgLTEuMDQ5ODEsMC42MjI1NTggLTEuMDQ5ODEsMi4xMjQwMjMgMCwxLjE5NjI4OSAwLjc4MTI1LDEuOTA0Mjk3IDAuNzkzNDYsMC42OTU4MDEgMi4xNDg0NCwwLjY5NTgwMSAxLjg2NzY4LDAgMi45OTA3MiwtMS4zMTgzNiAxLjEzNTI2LC0xLjMzMDU2NiAxLjEzNTI2LC0zLjUyNzgzMiB2IC0wLjUwMDQ4OCB6IG0gNC40Nzk5OCwtMC45Mjc3MzQgdiA3LjgwMDI5MyBoIC0yLjI0NjA5IHYgLTIuMDc1MTk2IHEgLTAuNzY5MDUsMS4yNDUxMTcgLTEuOTE2NTEsMS44NDMyNjIgLTEuMTQ3NDYsMC41ODU5MzcgLTIuODA3NjEsMC41ODU5MzcgLTIuMDk5NjEsMCAtMy4zNDQ3MywtMS4xNzE4NzUgLTEuMjMyOTEsLTEuMTg0MDgyIC0xLjIzMjkxLC0zLjE2MTYyMSAwLC0yLjMwNzEyOSAxLjUzODA4LC0zLjQ3OTAwNCAxLjU1MDMsLTEuMTcxODc1IDQuNjE0MjYsLTEuMTcxODc1IGggMy4xNDk0MiB2IC0wLjIxOTcyNiBxIDAsLTEuNTUwMjkzIC0xLjAyNTM5LC0yLjM5MjU3OCAtMS4wMTMxOSwtMC44NTQ0OTIgLTIuODU2NDUsLTAuODU0NDkyIC0xLjE3MTg3LDAgLTIuMjgyNzEsMC4yODA3NjEgLTEuMTEwODQsMC4yODA3NjIgLTIuMTM2MjMsMC44NDIyODUgdiAtMi4wNzUxOTUgcSAxLjIzMjkxLC0wLjQ3NjA3NCAyLjM5MjU3LC0wLjcwODAwOCAxLjE1OTY3LC0wLjI0NDE0IDIuMjU4MywtMC4yNDQxNCAyLjk2NjMxLDAgNC40MzExNiwxLjUzODA4NiAxLjQ2NDg0LDEuNTM4MDg2IDEuNDY0ODQsNC42NjMwODYgeiIKICAgICBzdHlsZT0iZm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDo1MDA7Zm9udC1zdHJldGNoOm5vcm1hbDtmb250LXNpemU6MjVweDtmb250LWZhbWlseTpNb250c2VycmF0Oy1pbmtzY2FwZS1mb250LXNwZWNpZmljYXRpb246J01vbnRzZXJyYXQgTWVkaXVtJztsZXR0ZXItc3BhY2luZzotMS4yMzAwMDAwMnB4IgogICAgIGlkPSJwYXRoMzcyNSIKICAgICBpbmtzY2FwZTpjb25uZWN0b3ItY3VydmF0dXJlPSIwIiAvPjxwYXRoCiAgICAgZD0ibSAxMzUuODk4NDIsMjYuODc2NjE3IHYgOC4yNTE5NTQgaCAtMi4yNDYwOSBWIDI2Ljk0OTg2IHEgMCwtMS45NDA5MTggLTAuNzU2ODQsLTIuOTA1Mjc0IC0wLjc1NjgzLC0wLjk2NDM1NSAtMi4yNzA1MSwtMC45NjQzNTUgLTEuODE4ODQsMCAtMi44Njg2NSwxLjE1OTY2OCAtMS4wNDk4LDEuMTU5NjY4IC0xLjA0OTgsMy4xNjE2MjEgdiA3LjcyNzA1MSBoIC0yLjI1ODMgViAyMS40NTY2OTYgaCAyLjI1ODMgdiAyLjEyNDAyMyBxIDAuODA1NjYsLTEuMjMyOTEgMS44OTIwOSwtMS44NDMyNjIgMS4wOTg2MywtMC42MTAzNTEgMi41MjY4NSwtMC42MTAzNTEgMi4zNTU5NiwwIDMuNTY0NDYsMS40NjQ4NDMgMS4yMDg0OSwxLjQ1MjYzNyAxLjIwODQ5LDQuMjg0NjY4IHoiCiAgICAgc3R5bGU9ImZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtdmFyaWFudDpub3JtYWw7Zm9udC13ZWlnaHQ6NTAwO2ZvbnQtc3RyZXRjaDpub3JtYWw7Zm9udC1zaXplOjI1cHg7Zm9udC1mYW1pbHk6TW9udHNlcnJhdDstaW5rc2NhcGUtZm9udC1zcGVjaWZpY2F0aW9uOidNb250c2VycmF0IE1lZGl1bSc7bGV0dGVyLXNwYWNpbmc6LTEuMjMwMDAwMDJweCIKICAgICBpZD0icGF0aDM3MjciCiAgICAgaW5rc2NhcGU6Y29ubmVjdG9yLWN1cnZhdHVyZT0iMCIgLz48cGF0aAogICAgIGQ9Im0gMTQxLjM5NDQ5LDE3LjU3NDg2IHYgMy44ODE4MzYgaCA0LjYyNjQ3IHYgMS43NDU2MDUgaCAtNC42MjY0NyB2IDcuNDIxODc1IHEgMCwxLjY3MjM2MyAwLjQ1MTY2LDIuMTQ4NDM4IDAuNDYzODcsMC40NzYwNzQgMS44Njc2OCwwLjQ3NjA3NCBoIDIuMzA3MTMgdiAxLjg3OTg4MyBoIC0yLjMwNzEzIHEgLTIuNjAwMSwwIC0zLjU4ODg3LC0wLjk2NDM1NiAtMC45ODg3NywtMC45NzY1NjIgLTAuOTg4NzcsLTMuNTQwMDM5IHYgLTcuNDIxODc1IGggLTEuNjQ3OTUgdiAtMS43NDU2MDUgaCAxLjY0Nzk1IFYgMTcuNTc0ODYgWiIKICAgICBzdHlsZT0iZm9udC1zdHlsZTpub3JtYWw7Zm9udC12YXJpYW50Om5vcm1hbDtmb250LXdlaWdodDo1MDA7Zm9udC1zdHJldGNoOm5vcm1hbDtmb250LXNpemU6MjVweDtmb250LWZhbWlseTpNb250c2VycmF0Oy1pbmtzY2FwZS1mb250LXNwZWNpZmljYXRpb246J01vbnRzZXJyYXQgTWVkaXVtJztsZXR0ZXItc3BhY2luZzotMS4yMzAwMDAwMnB4IgogICAgIGlkPSJwYXRoMzcyOSIKICAgICBpbmtzY2FwZTpjb25uZWN0b3ItY3VydmF0dXJlPSIwIiAvPjwvZz4KPC9zdmc+");/g' /usr/share/kibana/src/ui/ui_render/views/ui_app.jade /usr/share/kibana/src/ui/ui_render/views/chrome.jade
# custom HTML title information
RUN sed -i 's/title Kibana/title Grad-mgda/g' /usr/share/kibana/src/ui/ui_render/views/chrome.jade

# custom plugin css
COPY --from=builder /gradiant_style.zip /
RUN sed -i "s/commons.style.css'),/commons.style.css'),createAnchor('{{bundlePath}}\/gradiant_style.style.css'),/g" /usr/share/kibana/src/ui/ui_render/bootstrap/template.js.hbs
RUN bin/kibana-plugin install file:///gradiant_style.zip


