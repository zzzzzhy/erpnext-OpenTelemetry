FROM frappe/erpnext:v15

USER root

RUN bench get-app https://github.com/Simbotix/simbotix_otel.git && \
    bench build

RUN pip install \
    opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-exporter-otlp \
    opentelemetry-instrumentation \
    opentelemetry-instrumentation-wsgi \
    opentelemetry-instrumentation-requests \
    opentelemetry-instrumentation-redis \
    opentelemetry-instrumentation-pymysql \
    opentelemetry-instrumentation-logging

USER frappe