CREATE TABLE appointment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,

    appointment_date_time DATETIME NOT NULL,

    reason VARCHAR(255),
    status VARCHAR(50),

    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctor(id)
        ON DELETE CASCADE
);

CREATE TABLE treatment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    appointment_id BIGINT UNIQUE,

    description TEXT,
    cost DECIMAL(10,2),

    CONSTRAINT fk_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointment(id)
    ON DELETE CASCADE
);

CREATE TABLE patient (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(20)
);

CREATE TABLE doctor (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(20)
);
