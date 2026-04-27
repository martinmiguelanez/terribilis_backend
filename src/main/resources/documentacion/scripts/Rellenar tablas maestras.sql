
TRUNCATE taxonomic_class, taxonomic_order, taxonomic_family, diet_type, food, health_issue RESTART IDENTITY CASCADE;

-- 1. CLASES (Ampliadas)
INSERT INTO taxonomic_class (nombre) VALUES 
('Reptilia'), 
('Amphibia');

-- 2. ÓRDENES (Vinculados a las clases anteriores)
INSERT INTO taxonomic_order (nombre, class_id) VALUES 
('Squamata', 1),   -- Lagartos y serpientes
('Testudines', 1), -- Tortugas
('Anura', 2),      -- Ranas y sapos
('Caudata', 2),    -- Salamandras y tritones
('Crocodylia', 1); -- Cocodrilos y caimanes (por si acaso)


-- 3. FAMILIAS (Completo: Squamata, Testudines y Anura)
-- Squamata (ID 1)
INSERT INTO taxonomic_family (nombre, order_id) VALUES 
('Boidae', 1), ('Pythonidae', 1), ('Colubridae', 1), ('Viperidae', 1), ('Elapidae', 1),
('Gekkonidae', 1), ('Eublepharidae', 1), ('Phyllodactylidae', 1), ('Diplodactylidae', 1),
('Agamidae', 1), ('Chamaeleonidae', 1), ('Iguanidae', 1), ('Varanidae', 1), ('Teiidae', 1),
('Scincidae', 1), ('Lacertidae', 1), ('Helodermatidae', 1), ('Dactyloidae', 1);

-- Testudines (ID 2)
INSERT INTO taxonomic_family (nombre, order_id) VALUES 
('Testudinidae', 2), ('Emydidae', 2), ('Geoemydidae', 2), ('Cheloniidae', 2), 
('Chelydridae', 2), ('Kinosternidae', 2), ('Trionychidae', 2), ('Chelidae', 2);

-- Anura (ID 3)
INSERT INTO taxonomic_family (nombre, order_id) VALUES 
('Dendrobatidae', 3), ('Hylidae', 3), ('Pelodryadidae', 3), ('Phyllomedusidae', 3),
('Ceratophryidae', 3), ('Pyxicephalidae', 3), ('Ranidae', 3), ('Bufonidae', 3),
('Microhylidae', 3), ('Pipidae', 3), ('Rhacophoridae', 3), ('Mantellidae', 3);

-- Caudata (ID 4)
INSERT INTO taxonomic_family (nombre, order_id) VALUES 
('Ambystomatidae', 4), ('Salamandridae', 4), ('Plethodontidae', 4), ('Hynobiidae', 4);

-- 4. TIPOS DE DIETA
INSERT INTO diet_type (nombre) VALUES 
('Insectívoro'), ('Carnívoro'), ('Herbívoro'), ('Omnívoro'), 
('Frugívoro'), ('Piscívoro'), ('Molusquívoro');

-- 5. ALIMENTOS (Food) - Clasificados por tipo
INSERT INTO food (nombre) VALUES 
-- Insectos
('Grillo Acheta'), ('Grillo Bimaculatus'), ('Langosta migratoria'), ('Cucaracha Dubia'), 
('Cucaracha Runner'), ('Tenebrio molitor'), ('Zophobas morio'), ('Gusano de seda'), 
('Drosophila melanogaster'), ('Drosophila hydei'), ('Colémbolos'), ('Cochinilla de la jungla'),
-- Presa entera (Rodents/Others)
('Ratón Pinky'), ('Ratón Primer pelo'), ('Ratón Adulto'), ('Rata Puppy'), 
('Rata Adulta'), ('Pollito de un día'), ('Codorniz'),
-- Vegetales y Frutas
('Escarola'), ('Canónigos'), ('Rúcula'), ('Diente de león'), ('Calabacín'), 
('Zanahoria'), ('Papaya'), ('Higo'), ('Manzana (sin semillas)'),
-- Otros
('Pienso extrusionado'), ('Gelatina de frutas'), ('Pescado de río'), ('Caracoles/Babosas');

-- 6. SALUD (Health Issues) - Descripciones profesionales
INSERT INTO health_issue (nombre, descripcion) VALUES 
('Disecdisis', 'Retención de muda por falta de humedad o hidratación.'),
('Ácaros (Ophionyssus)', 'Parásitos externos hematófagos, requieren tratamiento químico.'),
('Estomatitis Infecciosa', 'Necrosis en tejidos bucales, común por estrés o mala higiene.'),
('Neumonía / I.R.', 'Dificultad respiratoria, mucosidad o sibilancias al respirar.'),
('EOM (MBD)', 'Descalcificación ósea grave por ratio Ca:P incorrecto o falta de UVB.'),
('Impactación', 'Obstrucción del tracto digestivo por sustrato o presas demasiado grandes.'),
('Distocia', 'Retención de huevos (unión de huevos) en hembras, urgencia veterinaria.'),
('Septicemia', 'Infección sistémica bacteriana (síndrome de pata roja en anfibios).'),
('Quitridiomicosis', 'Hongo letal en anfibios que afecta la queratina de la piel.'),
('Criptosporidiosis', 'Parásito protozoo muy contagioso y grave en serpientes y gecos.');

-- 7. SUPLEMENTOS
INSERT INTO supplement (nombre, descripcion, marca) VALUES 
-- CALCIOS (Básicos)
('Calcio Sin D3 (Fino)', 'Calcio en polvo ultra fino, sin fósforo. Para animales con mucha radiación UVB.', 'Exo Terra'),
('Calcio + D3 (Low)', 'Calcio con niveles bajos de D3 para animales de bosque o sombra.', 'Zoo Med'),
('Calcio + D3 (High)', 'Calcio con altos niveles de D3 para especies desérticas o sin UVB.', 'Repashy'),
('Calcio Líquido', 'Suplemento de absorción rápida para hembras en puesta o casos leves de EOM.', 'Exo Terra'),

-- VITAMINAS ESPECÍFICAS
('Vitamina A Plus', 'Vitamina A preformada. Esencial para anfibios y gecos para evitar problemas de muda y ojos.', 'Repashy'),
('Multivitamínico con Probióticos', 'Mezcla completa con bacterias beneficiosas para la digestión.', 'Arcadia'),
('B-Complex', 'Vitaminas del grupo B para apoyo al sistema nervioso y apetito.', 'Zoo Med'),

-- ALL-IN-ONE (Los favoritos de los criadores)
('Calcium Plus (All-in-One)', 'El suplemento diario estándar: mezcla de calcio, vitaminas y minerales.', 'Repashy'),
('EarthPro-A', 'Polvo mineral diario rico en arcillas naturales y vitaminas.', 'Arcadia'),
('Grub Pie', 'Suplemento nutricional completo en gel para insectívoros.', 'Repashy'),

-- MEJORA DE COLOR Y SALUD
('SuperPigment / Carotenoides', 'Potenciador de colores rojos, naranjas y amarillos (perfecto para Terribilis).', 'Repashy'),
('Polen de Abeja Puro', 'Suplemento natural muy apreciado por camaleones y herbívoros.', 'Zoo Med'),
('Electrolitos & B12', 'Solución de baño o rociado para animales estresados o deshidratados.', 'Exo Terra'),

-- MINERALES EXOTICOS
('Magnesium + Calcio', 'Fórmula específica para la contracción muscular y salud ósea.', 'Arcadia'),
('Shed-Ease', 'Suplemento para facilitar la muda de piel mediante aceites y vitaminas.', 'Zilla');
