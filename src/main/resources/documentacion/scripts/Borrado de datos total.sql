-- 1. Vaciado total con reinicio de contadores y cascada
TRUNCATE TABLE 
    -- Tablas de relación N:N y detalles (Hijas)
    diet_food,
    species_health,
    species_image,
    -- Tablas de relación 1:1 y 1:N (Hijas)
    brumation,
    environment,
    habitat,
    natural_habitat,
    species_diet,
    -- Tablas principales (Padres)
    species,
    -- Tablas maestras o de configuración (Cimientos)
    food,
    health_issue,
    diet_type,
    taxonomic_family,
    taxonomic_order,
    taxonomic_class
RESTART IDENTITY CASCADE;

SELECT 
    (SELECT COUNT(*) FROM species) as total_especies,
    (SELECT COUNT(*) FROM natural_habitat) as total_habitats,
    (SELECT COUNT(*) FROM species_image) as total_imagenes;


