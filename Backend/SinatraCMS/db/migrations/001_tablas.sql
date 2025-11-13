-- =============================================
-- SCRIPT DDL SQLITE3 - MODELO DE GESTIÓN DE TAREAS Y ESTADO DE ÁNIMO
-- =============================================

PRAGMA foreign_keys = ON;

-- ==== ENUMS Y CATÁLOGOS ====

CREATE TABLE EstadoTarea (
    id TEXT PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE MoodLevel (
    id TEXT PRIMARY KEY,
    nivel TEXT NOT NULL  -- valores esperados: 'BAJA', 'NEUTRA', 'ALTA'
);

-- ==== ENTIDADES PRINCIPALES ====

CREATE TABLE Usuario (
    id TEXT PRIMARY KEY,
    nombre TEXT NOT NULL,
    createdAt DATETIME NOT NULL
);

CREATE TABLE Settings (
    id TEXT PRIMARY KEY,
    notifsEnabled BOOLEAN NOT NULL DEFAULT 1,
    checkinReminderDaily BOOLEAN NOT NULL DEFAULT 0,
    checkinReminderHour INTEGER,
    deadlineAlerts BOOLEAN NOT NULL DEFAULT 1,
    usuarioId TEXT NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(id)
);

CREATE TABLE Curso (
    id TEXT PRIMARY KEY,
    nombre TEXT NOT NULL,
    usuarioId TEXT NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(id)
);

CREATE TABLE Tarea (
    id TEXT PRIMARY KEY,
    cursoId TEXT NOT NULL,
    settingsId TEXT NOT NULL,
    estadoId TEXT NOT NULL,
    titulo TEXT NOT NULL,
    deadline DATETIME,
    dificultadEstimada INTEGER,  -- 1..5 (derivado)
    energiaRequerida INTEGER,    -- 1..5 (derivado)
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NOT NULL,
    FOREIGN KEY (cursoId) REFERENCES Curso(id),
    FOREIGN KEY (settingsId) REFERENCES Settings(id),
    FOREIGN KEY (estadoId) REFERENCES EstadoTarea(id)
);

CREATE TABLE MoodLog (
    id TEXT PRIMARY KEY,
    usuarioId TEXT NOT NULL,
    moodId TEXT NOT NULL,
    fechaHora DATETIME NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(id),
    FOREIGN KEY (moodId) REFERENCES MoodLevel(id)
);

CREATE TABLE MoodLogTarea (
    id TEXT PRIMARY KEY,
    moodLogId TEXT NOT NULL,
    tareaId TEXT NOT NULL,
    tipo TEXT,  -- "recomendada", "realizada"
    FOREIGN KEY (moodLogId) REFERENCES MoodLog(id),
    FOREIGN KEY (tareaId) REFERENCES Tarea(id)
);

-- =============================================
-- ÍNDICES SUGERIDOS PARA OPTIMIZAR CONSULTAS
-- =============================================

CREATE INDEX idx_tarea_curso ON Tarea(cursoId);
CREATE INDEX idx_tarea_settings ON Tarea(settingsId);
CREATE INDEX idx_tarea_estado ON Tarea(estadoId);
CREATE INDEX idx_curso_usuario ON Curso(usuarioId);
CREATE INDEX idx_moodlog_usuario ON MoodLog(usuarioId);
CREATE INDEX idx_moodlogtarea_moodlog ON MoodLogTarea(moodLogId);
CREATE INDEX idx_moodlogtarea_tarea ON MoodLogTarea(tareaId);

