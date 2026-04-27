-- [1] ESPECIE (Padre)
-- Vinculada a la familia 7 (Hylidae) que ya insertamos antes
INSERT INTO species (id, nombre_comun, nombre_cientifico, descripcion, origen, dificultad, peligrosidad, esperanza_vida, tamaño_promedio_cm, peso_promedio_gramos, actividad, family_id) 
VALUES (1, 'Rana de Ojos Rojos', 'Agalychnis callidryas', 'Anfibio arborícola icónico de Centroamérica, famoso por sus vibrantes ojos rojos y costados azulados. Nocturno y de alta humedad.', 'Centroamérica', 'Media', 'Baja', 5, 7, 15, 'Nocturno', 7);

-- [2] ENTORNO (Environment)
INSERT INTO environment (id, temperatura_dia_max, temperatura_dia_min, humedad_max, humedad_min, uvb_requerido, species_id)
VALUES (1, 28, 24, 80, 60, true, 1);

-- [3] HÁBITAT (Configuración del terrario)
INSERT INTO habitat (id, tipo, tamaño_minimo_cm, sustrato, species_id)
VALUES (1, 'Terrario Arborícola (Vertical)', '45x45x60', 'Fibra de coco y musgo sphagnum', 1);

-- [4] HÁBITAT NATURAL (Origen biológico)
INSERT INTO natural_habitat (id, region, bioma, clima, altitud, species_id)
VALUES (1, 'Selvas de Centroamérica', 'Bosque tropical lluvioso', 'Húmedo Tropical', '0-1200m', 1);

-- [5] BRUMACIÓN
INSERT INTO brumation (id, requiere, meses, temperatura_min, temperatura_max, descripcion, species_id)
VALUES (1, false, '0', 0, 0, 'No requiere brumación, solo mantener ciclo día/noche.', 1);

-- [6] DIETA (Vinculación con tipo de dieta e insectos específicos)
-- Usamos diet_type_id = 1 (Insectívoro) que ya insertamos en las maestras
INSERT INTO species_diet (id, diet_type_id, observaciones, species_id) 
VALUES (1, 1, 'Insectívoro: prefiere presas vivas que se muevan mucho.', 1);

-- Enlazamos con la tabla intermedia diet_food (Grillo ID 1, Mosca ID 7)
INSERT INTO diet_food (species_diet_id, food_id, porcentaje) VALUES 
(1, 1, 80), -- 80% Grillos
(1, 7, 20); -- 20% Moscas de la fruta

-- [7] SALUD (Vinculada al health_issue ID 4: Infección Respiratoria)
INSERT INTO species_health (id, species_id, health_issue_id, prevencion)
VALUES (1, 1, 4, 'Mantener ventilación cruzada y evitar que el sustrato se encharque.');

-- [8] IMAGEN
INSERT INTO species_image (id, url, descripcion, species_id)
VALUES (1, '/img/species/agalychnisCallidryas.jpg', 'Rana de ojos rojos adulta', 1);