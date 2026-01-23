FROM frappe/erpnext:v15

USER frappe
RUN bench get-app https://github.com/Simbotix/simbotix_otel.git && \
    bench build
    
USER root
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
CMD ["/home/frappe/frappe-bench/env/bin/opentelemetry-instrument", \
     "/home/frappe/frappe-bench/env/bin/gunicorn", \
     "--chdir=/home/frappe/frappe-bench/sites", \
     "--bind=0.0.0.0:8000", \
     "--threads=4", \
     "--workers=2", \
     "--worker-class=gthread", \
     "--worker-tmp-dir=/dev/shm", \
     "--timeout=120", \
     "--preload", \
     "simbotix_otel.app:application"]