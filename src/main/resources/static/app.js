// URL base de la API desde donde se obtienen las especies
const API_URL = '/api/especies';

// Array global donde se almacenarán los datos recibidos de la API
let speciesData = [];

// Instancia del modal de detalle (Bootstrap)
let modalInstance = null;


// =======================
// INICIALIZACIÓN
// =======================

// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', () => {

    // Carga los datos desde la API
    loadSpecies();

    // Inicializa el modal de Bootstrap para mostrar detalles
    modalInstance = new bootstrap.Modal(
        document.getElementById('detailModal')
    );
});


// =======================
// CARGA DE DATOS DESDE API
// =======================
async function loadSpecies() {
    try {
        // Llamada a la API
        const response = await fetch(API_URL);

        // Si la respuesta no es correcta, lanzamos error
        if (!response.ok) throw new Error("Error de red");

        // Convertimos la respuesta a JSON
        speciesData = await response.json();
        
        // Renderizamos todas las especies al inicio
        renderGrid(speciesData);

        // Actualizamos contador con total de especies
        updateCounter(speciesData.length);

    } catch (error) {
        // Si falla la API, mostramos error en pantalla
        showError();
    }
}


// =======================
// FILTRO DE ESPECIES (UI + DOM)
// =======================
function filterSpecies(category, element) {

    // Seleccionamos todos los botones de filtro
    const buttons = document.querySelectorAll('.filter-btn');

    // Reseteamos todos los botones a estado "inactivo"
    buttons.forEach(btn => {
        btn.classList.remove('active', 'btn-warning');
        btn.classList.add('btn-outline-dark');
    });

    // Activamos solo el botón clicado
    element.classList.add('active', 'btn-warning');
    element.classList.remove('btn-outline-dark');


    // =======================
    // FILTRADO DE TARJETAS (DOM directo)
    // =======================

    // Seleccionamos todas las tarjetas de especies
    const cards = document.querySelectorAll('.species-card-col');

    // Mostramos u ocultamos según categoría
    cards.forEach(card => {

        // Si es "all" o coincide la categoría → mostrar
        if (category === 'all' || 
            card.getAttribute('data-category') === category) {

            card.style.display = 'block';

        } else {
            // Si no coincide → ocultar
            card.style.display = 'none';
        }
    });
}


// =======================
// CONTADOR DE ESPECIES
// =======================
function updateCounter(count) {

    // Actualiza el texto del badge con el número de especies visibles
    document.getElementById('count-badge').innerText =
        `${count} Especies visualizadas`;
}


// =======================
// RENDERIZADO DEL GRID
// =======================
function renderGrid(data) {

    // Contenedor donde se pintan las tarjetas
    const grid = document.getElementById('species-grid');
    

    // =======================
    // CASO: SIN DATOS
    // =======================
    if (data.length === 0) {
        grid.innerHTML = `
            <div class="col-12 text-center py-5">
                <i class="bi bi-search fs-1 text-muted"></i>
                <p class="mt-3 text-muted">
                    No hay especies registradas en esta categoría.
                </p>
            </div>`;
        return;
    }


    // =======================
    // RENDER DE TARJETAS
    // =======================
    grid.innerHTML = data.map(animal => {

        // Desestructuración del objeto animal
        const {
            id,
            dificultad,
            nombreComun,
            nombreCientifico,
            descripcion,
            images,
            environment,
            tamanoPromedioCm,
            familiaCompleta
        } = animal;
        
        // Color dinámico según dificultad
        const diffColor =
            dificultad === 'Principiante' ? 'success' :
            dificultad === 'Media' ? 'warning text-dark' :
            'danger';

        // Número de imágenes disponibles
        const imgCount = images?.length || 0;

        // Imagen principal (o placeholder si no hay)
        const firstImg =
            images?.[0]?.url ||
            'https://placehold.co/400x300?text=Sin+Imagen';


        // =======================
        // TEMPLATE HTML DE CADA TARJETA
        // =======================
        return `
            <div class="col">

                <div class="card species-card shadow-sm h-100">

                    <!-- CONTENEDOR DE IMAGEN -->
                    <div class="img-wrapper position-relative">

                        <!-- Badge de dificultad -->
                        <span class="difficulty-badge bg-${diffColor}" style="z-index: 10;">
                            ${dificultad || 'S/D'}
                        </span>
                        
                        <!-- Imagen clicable para abrir detalle -->
                        <div class="image-container h-100 w-100"
                             onclick="showDetail(${id})"
                             style="cursor:pointer;">

                            <img src="${firstImg}"
                                 id="img-card-${id}"
                                 class="species-img"
                                 alt="${nombreComun}">
                        </div>

                        <!-- Controles de imágenes (solo si hay más de 1) -->
                        ${imgCount > 1 ? `

                            <div class="card-controls">

                                <!-- Botón anterior -->
                                <button class="btn-card-nav prev"
                                    onclick="changeCardImage(${id}, -1, event)">
                                    <i class="bi bi-chevron-left"></i>
                                </button>

                                <!-- Botón siguiente -->
                                <button class="btn-card-nav next"
                                    onclick="changeCardImage(${id}, 1, event)">
                                    <i class="bi bi-chevron-right"></i>
                                </button>
                            </div>

                            <!-- Contador de imágenes -->
                            <span class="position-absolute bottom-0 end-0 m-2
                                         badge rounded-pill bg-dark bg-opacity-75"
                                  style="z-index: 10;">

                                <span id="counter-card-${id}">1</span>/${imgCount}
                            </span>

                        ` : ''}
                    </div>
                    
                    <!-- CONTENIDO DE LA TARJETA -->
                    <div class="card-body"
                         onclick="showDetail(${id})"
                         style="cursor: pointer;">

                        <!-- Familia -->
                        <small class="text-warning fw-bold x-small">
                            ${familiaCompleta || 'Sin Familia'}
                        </small>

                        <!-- Nombre común -->
                        <h4 class="card-title fw-bold mt-1 mb-0">
                            ${nombreComun}
                        </h4>

                        <!-- Nombre científico -->
                        <p class="text-muted small italic mb-2">
                            ${nombreCientifico}
                        </p>

                        <!-- Descripción -->
                        <p class="card-text text-secondary small mb-3 text-truncate">
                            ${descripcion || 'Sin descripción'}
                        </p>
                        
                        <!-- Estadísticas -->
                        <div class="row g-2 mt-auto">

                            ${renderStat(
                                'bi-thermometer-high text-danger',
                                `${environment?.temperaturaDiaMax || '--'}°C`
                            )}

                            ${renderStat(
                                'bi-droplet-fill text-primary',
                                `${environment?.humedadMax || '--'}%`
                            )}

                            ${renderStat(
                                'bi-rulers',
                                `${tamanoPromedioCm || '--'}cm`
                            )}

                        </div>
                    </div>

                </div>
            </div>`;
    }).join('');
}

// Objeto donde guardamos el índice actual de imagen por cada tarjeta (clave = animalId)
let cardImageIndices = {};


// =======================
// CAMBIO DE IMAGEN EN TARJETAS
// =======================
function changeCardImage(animalId, direction, event) {

    // Evita que el click en las flechas dispare otros eventos (como abrir el modal)
    if(event) event.stopPropagation();

    // Buscamos el animal correspondiente en los datos globales
    const animal = speciesData.find(a => a.id === animalId);

    // Si no existe o no tiene imágenes, salimos
    if (!animal || !animal.images) return;

    // Inicializamos el índice si no existe aún
    if (cardImageIndices[animalId] === undefined) {
        cardImageIndices[animalId] = 0;
    }

    // Total de imágenes disponibles
    const total = animal.images.length;

    // Cambio circular del índice (permite avanzar y retroceder en bucle)
    cardImageIndices[animalId] =
        (cardImageIndices[animalId] + direction + total) % total;

    // Actualizamos la imagen en el DOM
    document.getElementById(`img-card-${animalId}`).src =
        animal.images[cardImageIndices[animalId]].url;

    // Actualizamos el contador visual (1-based)
    document.getElementById(`counter-card-${animalId}`).innerText =
        cardImageIndices[animalId] + 1;
}


// =======================
// COMPONENTE: ESTADÍSTICA (ICONO + VALOR)
// =======================
function renderStat(icon, value) {

    // Devuelve un bloque HTML reutilizable con icono y valor
    return `
        <div class="col-4">
            <div class="stat-box text-center">
                <i class="${icon}"></i><br>
                <strong>${value}</strong>
            </div>
        </div>`;
}

function showDetail(id) {

    // Buscar animal
    const animal = speciesData.find(a => a.id === id);
    if (!animal) return;

    // Desestructuración
    const {
        id: animalId,
        nombreComun,
        nombreCientifico,
        actividad,
        images,
        tamanoPromedioCm,
        pesoPromedioGramos,
        esperanzaVida,
        naturalHabitat,
        habitat,
        environment,
        diets,
        brumation,
        healthIssues,
        supplements
    } = animal;

    // Badge de actividad
    const act = (actividad || '').toLowerCase();
    const actBadge =
        act.includes('diur') ? { icon: 'sun-fill text-warning', txt: 'Diurno' } :
        act.includes('noct') ? { icon: 'moon-stars-fill text-primary', txt: 'Nocturno' } :
        { icon: 'cloud-sun-fill text-secondary', txt: 'Crepuscular' };

    // Render modal
    document.getElementById('modal-body-content').innerHTML = `
        <div class="modal-header bg-dark text-white border-0 py-3">
            <div class="d-flex align-items-center">
                <i class="bi bi-clipboard2-pulse me-3 fs-3 text-warning"></i>
                <div>
                    <h5 class="modal-title fw-bold mb-0">${nombreComun}</h5>
                    <small class="text-uppercase opacity-75 italic">${nombreCientifico}</small>
                </div>
            </div>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body p-4">
            <div class="row g-4">

                <!-- IZQUIERDA -->
                <div class="col-md-5">

                    <!-- Imágenes -->
                    <div class="mb-3">
                        ${renderImageCarousel(images, animalId, nombreComun)}
                    </div>

                    <!-- Actividad -->
                    <div class="badge bg-dark w-100 p-2 mb-3">
                        <i class="bi bi-${actBadge.icon}"></i> ${actBadge.txt}
                    </div>

                    <!-- Stats -->
                    <div class="card bg-light border-0 rounded-4 mb-3">
                        <div class="card-body py-3 text-center">
                            <div class="row g-0">
                                ${renderMiniStat('Tamano', `${tamanoPromedioCm}cm`, true)}
                                ${renderMiniStat('Peso', `${pesoPromedioGramos}g`, true)}
                                ${renderMiniStat('Vida', `${esperanzaVida}a`, false)}
                            </div>
                        </div>
                    </div>

                    <!-- Hábitat natural -->
                    <div class="p-3 rounded-4 border bg-white shadow-sm">
                        <h6 class="fw-bold mb-3 small text-success text-uppercase">
                            <i class="bi bi-globe-americas me-2"></i>Hábitat Natural
                        </h6>

                        <div class="mb-2">
                            <small class="text-muted d-block">Región y Clima</small>
                            <span class="small fw-bold">${naturalHabitat?.region || 'N/A'}</span>
                            <span class="badge bg-success-subtle text-success ms-1">
                                ${naturalHabitat?.clima || 'N/A'}
                            </span>
                        </div>

                        <div>
                            <small class="text-muted d-block">Bioma específico</small>
                            <span class="small fw-bold">${naturalHabitat?.bioma || 'N/A'}</span>
                        </div>
                    </div>
                </div>


                <!-- DERECHA -->
                <div class="col-md-7">

                    <!-- TERRARIO -->
                    <section class="mb-4">
                        <h6 class="fw-bold border-bottom pb-2 text-primary">
                            <i class="bi bi-box-seam me-2"></i>CONFIGURACIÓN DEL TERRARIO
                        </h6>

                        <div class="row g-2 mt-1 mb-3">

                            <div class="col-6">
                                <div class="p-2 border rounded bg-white shadow-sm h-100">
                                    <small class="text-muted x-small d-block text-uppercase fw-bold">
                                        Tipo de Terrario
                                    </small>
                                    <div class="small fw-bold text-primary">
                                        ${habitat?.tipoTerrario || habitat?.tipo || 'No definido'}
                                    </div>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="p-2 border rounded bg-white shadow-sm h-100">
                                    <small class="text-muted x-small d-block text-uppercase fw-bold">
                                        Tamano Mínimo (L x A x H)
                                    </small>
                                    <div class="small fw-bold">
                                        <i class="bi bi-arrows-fullscreen me-1 text-secondary"></i>
                                        ${habitat?.tamanoMinimoCm || 'No definido'}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sustrato -->
                        <div class="mb-3">
                            <small class="fw-bold text-secondary x-small text-uppercase">
                                Mezcla de Sustrato
                            </small>
                            <div class="d-flex flex-wrap gap-1 mt-1">
                                ${
                                    habitat?.sustrato
                                    ? habitat.sustrato.split(',').map(s =>
                                        `<span class="badge bg-light text-dark border x-small">${s.trim()}</span>`
                                      ).join('')
                                    : '<span class="text-muted x-small">No definido</span>'
                                }
                            </div>
                        </div>

                        <!-- Decoración -->
                        <div class="mb-3">
                            <small class="fw-bold text-secondary x-small text-uppercase">
                                Decoración y Puntos Clave
                            </small>
                            <div class="d-flex flex-wrap gap-1 mt-1">
                                ${
                                    habitat?.decoracion
                                    ? habitat.decoracion.split(',').map(d => {
                                        let color =
                                            d.includes('Caliente') ? 'danger' :
                                            d.includes('Húmedo') ? 'info' :
                                            d.includes('Fría') ? 'primary' :
                                            'secondary';
                                        return `<span class="badge border border-${color}-subtle bg-${color}-subtle text-${color} x-small">${d.trim()}</span>`;
                                    }).join('')
                                    : '<span class="text-muted x-small">No definida</span>'
                                }
                            </div>
                        </div>

                        <!-- Enriquecimiento -->
                        <div class="mb-3">
                            <small class="fw-bold text-secondary x-small text-uppercase">
                                Enriquecimiento Ambiental
                            </small>
                            <div class="d-flex flex-wrap gap-1 mt-1">
                                ${
                                    habitat?.enriquecimiento
                                    ? habitat.enriquecimiento.split(',').map(e =>
                                        `<span class="badge rounded-pill bg-white text-dark border x-small">
                                            <i class="bi bi-stars text-warning me-1"></i>${e.trim()}
                                        </span>`
                                      ).join('')
                                    : '<span class="text-muted x-small">No definido</span>'
                                }
                            </div>
                        </div>
                    </section>

                    <!-- PARÁMETROS -->
                    <section class="mb-4">
                        <h6 class="fw-bold border-bottom pb-2 text-primary">
                            <i class="bi bi-thermometer-sun me-2"></i>PARÁMETROS AMBIENTALES
                        </h6>

                        <table class="table table-sm table-borderless mb-0">
                            <thead>
                                <tr class="x-small text-muted text-uppercase">
                                    <th>Parámetro</th>
                                    <th class="text-center">Día</th>
                                    <th class="text-center">Noche</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td class="small fw-bold pt-2">Temperatura</td>
                                    <td class="text-center pt-2">
                                        <span class="text-danger fw-bold">
                                            ${environment?.temperaturaDiaMin || '--'}° - ${environment?.temperaturaDiaMax || '--'}°C
                                        </span>
                                    </td>
                                    <td class="text-center pt-2">
                                        <span class="text-primary fw-bold">
                                            ${environment?.temperaturaNocheMin || '--'}° - ${environment?.temperaturaNocheMax || '--'}°C
                                        </span>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="small fw-bold pt-2">Humedad</td>
                                    <td colspan="2" class="text-info fw-bold text-center pt-2">
                                        <i class="bi bi-droplet-half me-1"></i>
                                        ${environment?.humedadMin || '--'}% - ${environment?.humedadMax || '--'}%
                                    </td>
                                </tr>

                                <tr class="bg-light">
                                    <td colspan="3" class="text-center py-1 rounded">
                                        <small class="fw-bold text-uppercase text-muted">
                                            <i class="bi bi-lightbulb-fill me-1"></i> Iluminación y Fotoperiodo
                                        </small>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="small fw-bold pt-2">Radiación UVB</td>
                                    <td colspan="2" class="text-center pt-2">
                                        ${
                                            environment?.uvbRequerido
                                            ? `<span class="badge rounded-pill bg-warning-subtle text-warning border border-warning-subtle px-3">SÍ (REQUERIDO)</span>`
                                            : `<span class="badge rounded-pill bg-light text-muted border px-3">NO NECESARIO</span>`
                                        }
                                    </td>
                                </tr>

                                <tr>
                                    <td class="small fw-bold pt-2">Ciclo de Luz</td>
                                    <td colspan="2" class="text-center pt-2">
                                        <span class="text-dark fw-bold">
                                            <i class="bi bi-clock-history me-1 text-primary"></i>
                                            ${environment?.horasLuz || '12'}h diarias
                                        </span>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </section>

                </div>
            </div>

            <!-- DIETA + SUPLEMENTOS -->
            <div class="row g-4 mt-2">

                <div class="col-md-6">
                    <section class="h-100 p-3 rounded-4 border">
                        <h6 class="fw-bold border-bottom pb-2 text-uppercase small text-secondary">
                            <i class="bi bi-egg-fried me-2"></i>
                            Dieta: ${diets?.[0]?.dietType?.nombre || 'N/A'}
                        </h6>

                        <div class="d-flex flex-wrap gap-1 my-2">
                            ${
                                diets?.[0]?.dietFoods?.map(df =>
                                    `<span class="badge bg-white text-dark border x-small">${df.food.nombre}</span>`
                                ).join('') || '<span class="text-muted x-small">No definida</span>'
                            }
                        </div>

                        <p class="x-small text-muted italic mb-0">
                            ${diets?.[0]?.observaciones || ''}
                        </p>
                    </section>
                </div>

                <div class="col-md-6">
                    <section class="h-100 p-3 rounded-4 border bg-light">
                        <h6 class="fw-bold border-bottom pb-2 text-warning text-uppercase small">
                            <i class="bi bi-capsule me-2"></i>Suplementación
                        </h6>

                        <div class="list-group list-group-flush rounded-3 overflow-hidden border">
                            ${
                                supplements && supplements.length > 0
                                ? supplements.map(s => `
                                    <div class="list-group-item p-2 bg-white">
                                        <div class="fw-bold x-small">${s.supplement.nombre}</div>
                                        <div class="x-small text-primary mt-1">
                                            <i class="bi bi-calendar-check me-1"></i>${s.observaciones}
                                        </div>
                                    </div>
                                `).join('')
                                : '<div class="list-group-item small italic text-muted text-center">Sin pauta</div>'
                            }
                        </div>
                    </section>
                </div>
            </div>

            <!-- SALUD -->
            <div class="mt-4 pt-3 border-top">
                <h6 class="fw-bold text-danger mb-3">
                    <i class="bi bi-heart-pulse me-2"></i>ALERTAS DE SALUD
                </h6>

                <div class="row g-2">
                    ${
                        healthIssues?.length > 0
                        ? healthIssues.map(hi => `
                            <div class="col-md-6">
                                <div class="p-2 border-start border-danger border-4 bg-light h-100 shadow-sm">
                                    <div class="small fw-bold text-dark">${hi.healthIssue.nombre}</div>
                                    <div class="text-muted italic mb-1" style="font-size: 0.65rem;">
                                        ${hi.healthIssue.descripcion || ''}
                                    </div>
                                    <div class="p-1 mt-1 rounded bg-white" style="font-size: 0.7rem; border: 1px dashed #dc3545;">
                                        <span class="fw-bold text-danger">Prevención:</span> ${hi.prevencion || 'No especificada'}
                                    </div>
                                </div>
                            </div>
                        `).join('')
                        : '<p class="small italic text-muted px-2">Sin alertas registradas.</p>'
                    }
                </div>
            </div>

        </div>
    `;

    // Mostrar modal
    modalInstance.show();
}

// =======================
// COMPONENTE: MINI STAT (LABEL + VALOR + BORDE OPCIONAL)
// =======================
function renderMiniStat(label, value, border) {

    // Devuelve un bloque de UI reutilizable para mostrar datos pequenos en columnas
    return `
        <div class="col-4 ${border ? 'border-end' : ''}">
            <div class="x-small text-muted">${label}</div>
            <div class="fw-bold">${value}</div>
        </div>`;
}


// =======================
// ERROR DE CARGA DE API
// =======================
function showError() {

    // Sustituye el grid por un mensaje de error si falla la API
    document.getElementById('species-grid').innerHTML =
        `<div class="col-12 alert alert-danger text-center">
            Error al conectar con la API.
        </div>`;
}


// =======================
// CARGA DINÁMICA DEL MODAL ADMIN
// =======================
document.addEventListener('click', async (e) => {
    const targetBtn = e.target.closest('#btnNuevoAnimal') || 
                     e.target.closest('[data-bs-target="#adminModal"]');

    if (!targetBtn) return;
    e.preventDefault();

    try {
        const response = await fetch('admin_form.html');
        if (!response.ok) throw new Error("No se pudo cargar el formulario");
        const html = await response.text();

        const adminModalEl = document.getElementById('adminModal');
        
        // Si ya había una instancia abierta, la cerramos antes de inyectar
        const existingInstance = bootstrap.Modal.getInstance(adminModalEl);
        if (existingInstance) {
            existingInstance.dispose();
        }

        adminModalEl.innerHTML = html;
        const adminModalInstance = new bootstrap.Modal(adminModalEl, {
            backdrop: 'static', // Evita que se cierre por error al clickear fuera
            keyboard: true
        });

        adminModalInstance.show();

        if (typeof window.initAdminLogic === 'function') {
            window.initAdminLogic();
        }

    } catch (error) {
        console.error("Error:", error);
    }
});

// =======================
// FIX ACCESIBILIDAD MODAL (ARIA-HIDDEN WARNING)
// =======================

// Cuando el modal empieza a cerrarse, se elimina el foco activo
document.addEventListener('hide.bs.modal', (e) => {
    if (e.target.id === 'adminModal') {

        // Evita warning de aria-hidden al mantener foco en elemento oculto
        if (document.activeElement instanceof HTMLElement) {
            document.activeElement.blur();
        }
    }
});


// Cuando el modal ya se ha cerrado completamente
document.addEventListener('hidden.bs.modal', (e) => {
    if (e.target.id === 'adminModal') {
        // Eliminamos el contenido para evitar IDs duplicados la próxima vez
        e.target.innerHTML = '';
        
        // FORZAMOS la eliminación del fondo negro si Bootstrap se queda "pegado"
        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) {
            backdrop.remove();
        }
        
        // Devolvemos el scroll al cuerpo de la página
        document.body.classList.remove('modal-open');
        document.body.style.overflow = '';
        document.body.style.paddingRight = '';
    }
});


// =======================
// RENDER DE CAROUSEL DE IMÁGENES
// =======================
function renderImageCarousel(images, animalId, animalName) {

    // Si no hay imágenes, mostramos placeholder
    if (!images || images.length === 0) {
        return `
            <img src="https://placehold.co/600x400?text=Sin+Imagen"
                 class="img-fluid rounded-4 shadow-sm border"
                 alt="Sin imagen">`;
    }

    // ID único del carousel por animal
    const carouselId = `carousel-${animalId}`;

    // =======================
    // MINIATURAS (INDICADORES)
    // =======================
    const indicatorsHtml = images.map((img, index) => `
        <button type="button"
                data-bs-target="#${carouselId}"
                data-bs-slide-to="${index}"
                class="${index === 0 ? 'active' : ''}"
                style="width: 60px; height: 45px; border: 2px solid #ddd; padding: 0; border-radius: 6px; overflow: hidden; background: #000;">

            <img src="${img.url}"
                 class="w-100 h-100"
                 style="object-fit: cover; opacity: 0.8;"
                 alt="Mini">
        </button>
    `).join('');

    // =======================
    // SLIDES DEL CAROUSEL
    // =======================
    const itemsHtml = images.map((img, index) => `
        <div class="carousel-item ${index === 0 ? 'active' : ''}">
            <img src="${img.url}"
                 class="d-block w-100 rounded-4 shadow-sm border border-white border-2"
                 alt="${animalName}"
                 style="aspect-ratio: 4/3; object-fit: cover; object-position: center;">
        </div>
    `).join('');

    // =======================
    // ESTRUCTURA FINAL CAROUSEL
    // =======================
    return `
        <div id="${carouselId}"
             class="carousel slide mb-2"
             data-bs-ride="false">

            <div class="carousel-inner">
                ${itemsHtml}
            </div>

            ${
                images.length > 1 ? `
                <!-- CONTROLES -->
                <button class="carousel-control-prev"
                        type="button"
                        data-bs-target="#${carouselId}"
                        data-bs-slide="prev">

                    <span class="carousel-control-prev-icon p-3 rounded-circle bg-dark bg-opacity-25"></span>
                </button>

                <button class="carousel-control-next"
                        type="button"
                        data-bs-target="#${carouselId}"
                        data-bs-slide="next">

                    <span class="carousel-control-next-icon p-3 rounded-circle bg-dark bg-opacity-25"></span>
                </button>
                ` : ''
            }
        </div>

        ${
            images.length > 1 ? `
            <!-- MINIATURAS -->
            <div class="d-flex gap-2 mt-2 pb-1 overflow-x-auto justify-content-start px-1">
                ${indicatorsHtml}
            </div>
            ` : ''
        }
    `;
}


// =======================
// FILTRO GLOBAL DE ESPECIES
// =======================
window.filterSpecies = function(clase, btn) {

    // Debug en consola
    console.log("Filtrando por:", clase);

    // =======================
    // UI: estado de botones
    // =======================
    document.querySelectorAll('.filter-btn').forEach(b => {
        b.classList.remove('active', 'bg-warning', 'text-dark');
        b.classList.add('btn-outline-dark');
    });

    btn.classList.add('active', 'bg-warning', 'text-dark');
    btn.classList.remove('btn-outline-dark');


    // =======================
    // LÓGICA DE FILTRADO
    // =======================
    const filtered =
        clase === 'all'
        ? speciesData
        : speciesData.filter(a =>
            (a.familiaCompleta &&
             a.familiaCompleta.toLowerCase().includes(clase.toLowerCase())) ||

            (a.clase &&
             a.clase.toLowerCase().includes(clase.toLowerCase()))
        );


    // =======================
    // RENDER + CONTADOR
    // =======================
    renderGrid(filtered);

    const badge = document.getElementById('count-badge');
    if (badge) {
        badge.innerText = `${filtered.length} Especies visualizadas`;
    }
};