-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2023-06-10 13:00:50 COT
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cliente (
    codigo_cli_id        INTEGER NOT NULL,
    nombre_cli           VARCHAR2(55) NOT NULL,
    ape_paterno_cli      VARCHAR2(55) NOT NULL,
    ape_materno_cli      VARCHAR2(55) NOT NULL,
    genero_cli           VARCHAR2(20) NOT NULL,
    fecha_nacimiento_cli DATE NOT NULL,
    direccion_cli        VARCHAR2(30) NOT NULL,
    telefono_cli         VARCHAR2(15) NOT NULL,
    fecha_creacion_cli   DATE NOT NULL
)
LOGGING;

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( codigo_cli_id );

CREATE TABLE empleados (
    codigo_emp_id          INTEGER NOT NULL,
    nombres_emp            VARCHAR2(55) NOT NULL,
    apellidos_emp          VARCHAR2(55) NOT NULL,
    cargo_emp              VARCHAR2(40) NOT NULL,
    fecha_contratacion_emp DATE NOT NULL,
    salario_emp            NUMBER(9, 2) NOT NULL,
    direccion_emp          VARCHAR2(30) NOT NULL,
    telefono_emp           VARCHAR2(15),
    correo_emp             VARCHAR2(40) NOT NULL
)
LOGGING;

ALTER TABLE empleados ADD CONSTRAINT empleados_pk PRIMARY KEY ( codigo_emp_id );

CREATE TABLE envios (
    codigo_env_id                INTEGER NOT NULL,
    fecha_env                    DATE NOT NULL,
    direccion_env                VARCHAR2(30) NOT NULL,
    metodo_env                   VARCHAR2(30) NOT NULL,
    estado_env                   SMALLINT NOT NULL,
    costo_env                    NUMBER(9, 2) NOT NULL,
    empleados_codigo_emp_id      INTEGER NOT NULL,
    ventas_codigo_vts_id         INTEGER NOT NULL,
    ventas_cliente_codigo_cli_id INTEGER NOT NULL
)
LOGGING;

CREATE UNIQUE INDEX envios__idx ON
    envios (
        ventas_codigo_vts_id
    ASC,
        ventas_cliente_codigo_cli_id
    ASC );

ALTER TABLE envios ADD CONSTRAINT envios_pk PRIMARY KEY ( codigo_env_id,
                                                          empleados_codigo_emp_id );

CREATE TABLE productos (
    codigo_prod_id   INTEGER NOT NULL,
    nombre_prod      VARCHAR2(50) NOT NULL,
    descripcion_prod VARCHAR2(100) NOT NULL,
    precio_prod      NUMBER(9, 2) NOT NULL,
    stock_prod       INTEGER NOT NULL
)
LOGGING;

ALTER TABLE productos ADD CONSTRAINT productos_pk PRIMARY KEY ( codigo_prod_id );

CREATE TABLE ventas (
    codigo_vts_id         INTEGER NOT NULL,
    fecha_vts             DATE NOT NULL,
    descuento_vts         NUMBER(5, 2),
    total_vts             NUMBER(9, 2) NOT NULL,
    cliente_codigo_cli_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE ventas ADD CONSTRAINT ventas_pk PRIMARY KEY ( codigo_vts_id,
                                                          cliente_codigo_cli_id );

CREATE TABLE ventas_productos (
    ventas_codigo_vts_id         INTEGER NOT NULL,
    ventas_cliente_codigo_cli_id INTEGER NOT NULL,
    productos_codigo_prod_id     INTEGER NOT NULL
)
LOGGING;

ALTER TABLE ventas_productos
    ADD CONSTRAINT ventas_productos_pk PRIMARY KEY ( ventas_codigo_vts_id,
                                                     ventas_cliente_codigo_cli_id,
                                                     productos_codigo_prod_id );

ALTER TABLE envios
    ADD CONSTRAINT envios_empleados_fk FOREIGN KEY ( empleados_codigo_emp_id )
        REFERENCES empleados ( codigo_emp_id )
    NOT DEFERRABLE;

ALTER TABLE envios
    ADD CONSTRAINT envios_ventas_fk FOREIGN KEY ( ventas_codigo_vts_id,
                                                  ventas_cliente_codigo_cli_id )
        REFERENCES ventas ( codigo_vts_id,
                            cliente_codigo_cli_id )
    NOT DEFERRABLE;

ALTER TABLE ventas
    ADD CONSTRAINT ventas_cliente_fk FOREIGN KEY ( cliente_codigo_cli_id )
        REFERENCES cliente ( codigo_cli_id )
    NOT DEFERRABLE;

ALTER TABLE ventas_productos
    ADD CONSTRAINT ventas_productos_productos_fk FOREIGN KEY ( productos_codigo_prod_id )
        REFERENCES productos ( codigo_prod_id )
    NOT DEFERRABLE;

ALTER TABLE ventas_productos
    ADD CONSTRAINT ventas_productos_ventas_fk FOREIGN KEY ( ventas_codigo_vts_id,
                                                            ventas_cliente_codigo_cli_id )
        REFERENCES ventas ( codigo_vts_id,
                            cliente_codigo_cli_id )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
