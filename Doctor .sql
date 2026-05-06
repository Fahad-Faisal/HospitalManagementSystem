-- Doctor Module SQL

CREATE TABLE doctor (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    doctor_id VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(50) NOT NULL,
    specialization VARCHAR(255),
    qualification VARCHAR(255),
    experience INT,
    password VARCHAR(255) NOT NULL
);
