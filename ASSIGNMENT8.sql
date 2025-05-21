-- Table: Staff
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role ENUM('Manager', 'Caretaker', 'Veterinarian', 'Receptionist') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);

-- Table: Adopters
CREATE TABLE Adopters (
    adopter_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255) NOT NULL
);

-- Table: Pets
CREATE TABLE Pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species ENUM('Dog', 'Cat', 'Rabbit', 'Bird', 'Other') NOT NULL,
    breed VARCHAR(50),
    birth_date DATE,
    intake_date DATE NOT NULL,
    status ENUM('Available', 'Adopted', 'Fostered', 'Medical Hold') NOT NULL DEFAULT 'Available'
);

-- Table: Adoptions (Many-to-Many: Adopters <-> Pets)
CREATE TABLE Adoptions (
    adoption_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    adopter_id INT NOT NULL,
    staff_id INT NOT NULL,
    adoption_date DATE NOT NULL,
    fee DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_pet
        FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    CONSTRAINT fk_adopter
        FOREIGN KEY (adopter_id) REFERENCES Adopters(adopter_id),
    CONSTRAINT fk_staff
        FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    CONSTRAINT uc_pet_adoption UNIQUE (pet_id)
);

-- Table: MedicalRecords (One-to-Many: Pets -> MedicalRecords)
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    staff_id INT NOT NULL,
    visit_date DATE NOT NULL,
    notes TEXT,
    treatment VARCHAR(255),
    CONSTRAINT fk_medical_pet
        FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    CONSTRAINT fk_medical_staff
        FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- Table: FosterHomes
CREATE TABLE FosterHomes (
    foster_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL
);

-- Table: Fosters (Many-to-Many: Pets <-> FosterHomes)
CREATE TABLE Fosters (
    foster_record_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    foster_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    CONSTRAINT fk_foster_pet
        FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    CONSTRAINT fk_foster_home
        FOREIGN KEY (foster_id) REFERENCES FosterHomes(foster_id)
);