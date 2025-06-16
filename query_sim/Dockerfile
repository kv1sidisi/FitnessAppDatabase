FROM python:3.9-slim
RUN pip install psycopg2-binary prometheus-client
COPY sim.py /app/sim.py
WORKDIR /app
CMD ["python", "sim.py"]