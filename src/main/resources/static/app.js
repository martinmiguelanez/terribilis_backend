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

        <!-- HEADER -->
        <div class="modal-header border-0 p-0">
            <div class="w-100 px-4 py-3 d-flex align-items-center justify-content-between"
                 style="background:linear-gradient(135deg,#0d1117 0%,#161b22 100%);border-bottom:2px solid #ffc107;">
                <div class="d-flex align-items-center gap-3">
                    <div style="width:48px;height:48px;background:rgba(255,193,7,0.1);border:1px solid rgba(255,193,7,0.25);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="bi bi-clipboard2-pulse fs-4 text-warning"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0 text-white" style="font-family:'Montserrat',sans-serif;">${nombreComun}</h5>
                        <small class="text-warning opacity-70" style="font-style:italic;font-size:0.78rem;opacity:0.75;">${nombreCientifico}</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
        </div>

        <div class="modal-body p-4" style="background:#f8f9fb;">
            <div class="row g-4">

                <!-- IZQUIERDA -->
                <div class="col-md-5 d-flex flex-column gap-3">

                    <!-- Imágenes -->
                    <div>${renderImageCarousel(images, animalId, nombreComun)}</div>

                    <!-- Actividad -->
                    <div class="d-flex align-items-center gap-2 px-3 py-2 rounded-3"
                         style="background:${act.includes('diur') ? 'rgba(255,193,7,0.08)' : act.includes('noct') ? 'rgba(99,102,241,0.08)' : 'rgba(100,116,139,0.08)'};
                                border:1px solid ${act.includes('diur') ? 'rgba(255,193,7,0.22)' : act.includes('noct') ? 'rgba(99,102,241,0.22)' : 'rgba(100,116,139,0.22)'};">
                        <i class="bi bi-${actBadge.icon}" style="font-size:1.1rem;color:${act.includes('diur') ? '#ffc107' : act.includes('noct') ? '#818cf8' : '#94a3b8'};"></i>
                        <span class="fw-bold small" style="color:${act.includes('diur') ? '#b45309' : act.includes('noct') ? '#4f46e5' : '#6b7280'};">${actBadge.txt}</span>
                    </div>

                    <!-- Stats strip oscuro -->
                    <div class="rounded-3 overflow-hidden" style="background:#0d1117;border:1px solid rgba(255,255,255,0.06);">
                        <div class="row g-0">
                            ${renderMiniStat('Tamaño', `${tamanoPromedioCm || '--'}cm`, true)}
                            ${renderMiniStat('Peso', `${pesoPromedioGramos || '--'}g`, true)}
                            ${renderMiniStat('Vida', `${esperanzaVida || '--'}a`, false)}
                        </div>
                    </div>

                    <!-- Hábitat natural -->
                    <div class="rounded-3 p-3" style="background:#fff;border:1px solid #e5e7eb;">
                        <p class="fw-bold mb-2" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#16a34a;border-bottom:1px solid #dcfce7;padding-bottom:6px;">
                            <i class="bi bi-globe-americas me-2"></i>Hábitat Natural
                        </p>
                        <div class="mb-2">
                            <small class="text-muted d-block" style="font-size:0.68rem;">Región y Clima</small>
                            <span class="small fw-bold">${naturalHabitat?.region || 'N/A'}</span>
                            <span class="ms-1" style="display:inline-block;padding:2px 8px;border-radius:20px;font-size:0.58rem;font-weight:700;background:rgba(22,163,74,0.08);color:#16a34a;border:1px solid rgba(22,163,74,0.2);">${naturalHabitat?.clima || 'N/A'}</span>
                        </div>
                        <div>
                            <small class="text-muted d-block" style="font-size:0.68rem;">Bioma</small>
                            <span class="small fw-bold">${naturalHabitat?.bioma || 'N/A'}</span>
                        </div>
                    </div>
                </div>

                <!-- DERECHA -->
                <div class="col-md-7 d-flex flex-column gap-3">

                    <!-- Terrario -->
                    <div class="rounded-3 p-3" style="background:#fff;border:1px solid #e5e7eb;">
                        <p class="fw-bold mb-3" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#2563eb;border-bottom:1px solid #dbeafe;padding-bottom:6px;">
                            <i class="bi bi-box-seam me-2"></i>Configuración del Terrario
                        </p>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <div class="p-2 rounded-2" style="background:#eff6ff;border:1px solid #dbeafe;">
                                    <small class="d-block" style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#1e40af;letter-spacing:0.5px;">Tipo</small>
                                    <div class="small fw-bold text-primary">${habitat?.tipoTerrario || habitat?.tipo || 'No definido'}</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-2 rounded-2" style="background:#f8f9fb;border:1px solid #e5e7eb;">
                                    <small class="d-block" style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#6b7280;letter-spacing:0.5px;">Tamaño mínimo</small>
                                    <div class="small fw-bold"><i class="bi bi-arrows-fullscreen me-1 text-secondary"></i>${habitat?.tamanoMinimoCm || 'N/A'}</div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-2">
                            <small class="d-block mb-1" style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#6b7280;letter-spacing:0.5px;">Sustrato</small>
                            <div class="d-flex flex-wrap gap-1">
                                ${habitat?.sustrato
                                    ? habitat.sustrato.split(',').map(s =>
                                        `<span style="display:inline-block;padding:2px 8px;border-radius:6px;font-size:0.6rem;font-weight:600;background:#f1f5f9;color:#475569;border:1px solid #e2e8f0;">${s.trim()}</span>`
                                      ).join('')
                                    : '<span class="text-muted" style="font-size:0.75rem;">No definido</span>'}
                            </div>
                        </div>

                        <div class="mb-2">
                            <small class="d-block mb-1" style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#6b7280;letter-spacing:0.5px;">Decoración</small>
                            <div class="d-flex flex-wrap gap-1">
                                ${habitat?.decoracion
                                    ? habitat.decoracion.split(',').map(d => {
                                        let bg, color, border;
                                        if (d.includes('Caliente'))     { bg='#fff1f2'; color='#e11d48'; border='#fecdd3'; }
                                        else if (d.includes('Húmedo'))  { bg='#ecfeff'; color='#0891b2'; border='#a5f3fc'; }
                                        else if (d.includes('Fría'))    { bg='#eff6ff'; color='#2563eb'; border='#bfdbfe'; }
                                        else                            { bg='#f8fafc'; color='#64748b'; border='#e2e8f0'; }
                                        return `<span style="display:inline-block;padding:2px 8px;border-radius:6px;font-size:0.6rem;font-weight:600;background:${bg};color:${color};border:1px solid ${border};">${d.trim()}</span>`;
                                    }).join('')
                                    : '<span class="text-muted" style="font-size:0.75rem;">No definida</span>'}
                            </div>
                        </div>

                        <div>
                            <small class="d-block mb-1" style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#6b7280;letter-spacing:0.5px;">Enriquecimiento</small>
                            <div class="d-flex flex-wrap gap-1">
                                ${habitat?.enriquecimiento
                                    ? habitat.enriquecimiento.split(',').map(e =>
                                        `<span style="display:inline-block;padding:2px 8px;border-radius:6px;font-size:0.6rem;font-weight:600;background:#fefce8;color:#854d0e;border:1px solid #fef08a;"><i class="bi bi-stars me-1"></i>${e.trim()}</span>`
                                      ).join('')
                                    : '<span class="text-muted" style="font-size:0.75rem;">No definido</span>'}
                            </div>
                        </div>
                    </div>

                    <!-- Parámetros ambientales -->
                    <div class="rounded-3 p-3" style="background:#fff;border:1px solid #e5e7eb;">
                        <p class="fw-bold mb-3" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#2563eb;border-bottom:1px solid #dbeafe;padding-bottom:6px;">
                            <i class="bi bi-thermometer-sun me-2"></i>Parámetros Ambientales
                        </p>

                        <div class="row g-2 mb-2">
                            <div class="col-6">
                                <div class="p-2 rounded-2 text-center" style="background:#fff1f2;border:1px solid #fecdd3;">
                                    <small class="d-block" style="font-size:0.58rem;text-transform:uppercase;font-weight:800;color:#9f1239;letter-spacing:0.5px;">Temperatura Día</small>
                                    <span class="fw-bold" style="color:#e11d48;font-size:0.9rem;">${environment?.temperaturaDiaMin || '--'}° – ${environment?.temperaturaDiaMax || '--'}°C</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-2 rounded-2 text-center" style="background:#eff6ff;border:1px solid #bfdbfe;">
                                    <small class="d-block" style="font-size:0.58rem;text-transform:uppercase;font-weight:800;color:#1e40af;letter-spacing:0.5px;">Temperatura Noche</small>
                                    <span class="fw-bold" style="color:#2563eb;font-size:0.9rem;">${environment?.temperaturaNocheMin || '--'}° – ${environment?.temperaturaNocheMax || '--'}°C</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-2 rounded-2 text-center" style="background:#ecfeff;border:1px solid #a5f3fc;">
                                    <small class="d-block" style="font-size:0.58rem;text-transform:uppercase;font-weight:800;color:#164e63;letter-spacing:0.5px;">Humedad</small>
                                    <span class="fw-bold" style="color:#0891b2;font-size:0.9rem;"><i class="bi bi-droplet-half me-1"></i>${environment?.humedadMin || '--'}% – ${environment?.humedadMax || '--'}%</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-2 rounded-2 text-center" style="background:#fefce8;border:1px solid #fef08a;">
                                    <small class="d-block" style="font-size:0.58rem;text-transform:uppercase;font-weight:800;color:#713f12;letter-spacing:0.5px;">Ciclo de Luz</small>
                                    <span class="fw-bold" style="color:#92400e;font-size:0.9rem;"><i class="bi bi-clock-history me-1"></i>${environment?.horasLuz || '12'}h/día</span>
                                </div>
                            </div>
                        </div>

                        <div class="text-center py-2 rounded-2" style="background:${environment?.uvbRequerido ? 'rgba(255,193,7,0.08)' : '#f8f9fb'};border:1px solid ${environment?.uvbRequerido ? 'rgba(255,193,7,0.25)' : '#e5e7eb'};">
                            <small style="font-size:0.6rem;text-transform:uppercase;font-weight:800;color:#6b7280;letter-spacing:0.5px;">Radiación UVB</small>
                            <div class="fw-bold mt-1" style="color:${environment?.uvbRequerido ? '#d97706' : '#9ca3af'};font-size:0.85rem;">
                                ${environment?.uvbRequerido
                                    ? '<i class="bi bi-sun-fill me-1"></i>REQUERIDO'
                                    : '<i class="bi bi-dash-circle me-1"></i>No necesario'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- DIETA + SUPLEMENTOS -->
            <div class="row g-3 mt-1">
                <div class="col-md-6">
                    <div class="rounded-3 p-3 h-100" style="background:#fff;border:1px solid #e5e7eb;">
                        <p class="fw-bold mb-2" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#d97706;border-bottom:1px solid #fef3c7;padding-bottom:6px;">
                            <i class="bi bi-egg-fried me-2"></i>Dieta: ${diets?.[0]?.dietType?.nombre || 'N/A'}
                        </p>
                        <div class="d-flex flex-wrap gap-1 mb-2">
                            ${diets?.[0]?.dietFoods?.map(df =>
                                `<span style="display:inline-block;padding:2px 9px;border-radius:6px;font-size:0.62rem;font-weight:600;background:#fff7ed;color:#9a3412;border:1px solid #fed7aa;">${df.food.nombre}</span>`
                            ).join('') || '<span class="text-muted" style="font-size:0.75rem;">No definida</span>'}
                        </div>
                        <p class="mb-0" style="font-size:0.72rem;font-style:italic;color:#9ca3af;">${diets?.[0]?.observaciones || ''}</p>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="rounded-3 p-3 h-100" style="background:#fff;border:1px solid #e5e7eb;">
                        <p class="fw-bold mb-2" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#7c3aed;border-bottom:1px solid #ede9fe;padding-bottom:6px;">
                            <i class="bi bi-capsule me-2"></i>Suplementación
                        </p>
                        <div class="d-flex flex-column gap-1">
                            ${supplements?.length > 0
                                ? supplements.map(s => `
                                    <div class="d-flex align-items-start gap-2 py-1" style="border-bottom:1px solid #f5f3ff;">
                                        <i class="bi bi-capsule text-info mt-1" style="font-size:0.7rem;flex-shrink:0;"></i>
                                        <div>
                                            <div class="fw-bold" style="font-size:0.75rem;">${s.supplement.nombre}</div>
                                            <div style="font-size:0.68rem;color:#7c3aed;">${s.observaciones}</div>
                                        </div>
                                    </div>
                                `).join('')
                                : '<span class="text-muted" style="font-size:0.75rem;font-style:italic;">Sin pauta de suplementación</span>'}
                        </div>
                    </div>
                </div>
            </div>

            <!-- SALUD -->
            ${healthIssues?.length > 0 ? `
            <div class="mt-3 rounded-3 p-3" style="background:#fff;border:1px solid #fecaca;">
                <p class="fw-bold mb-3" style="font-size:0.65rem;text-transform:uppercase;letter-spacing:1.5px;color:#dc2626;border-bottom:1px solid #fecaca;padding-bottom:6px;">
                    <i class="bi bi-heart-pulse me-2"></i>Alertas de Salud
                </p>
                <div class="row g-2">
                    ${healthIssues.map(hi => `
                        <div class="col-md-6">
                            <div class="p-2 rounded-2 h-100" style="background:#fff5f5;border-left:3px solid #dc2626;border:1px solid #fecaca;border-left:3px solid #dc2626;">
                                <div class="fw-bold" style="font-size:0.78rem;">${hi.healthIssue.nombre}</div>
                                <div class="mb-1" style="font-size:0.65rem;color:#9ca3af;font-style:italic;">${hi.healthIssue.descripcion || ''}</div>
                                <div class="px-2 py-1 rounded-1" style="background:#fff;border:1px dashed #dc2626;font-size:0.68rem;">
                                    <span class="fw-bold text-danger">Prevención:</span> ${hi.prevencion || 'No especificada'}
                                </div>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
            ` : ''}

        </div>
    `;

    // Mostrar modal
    modalInstance.show();
}

// =======================
// COMPONENTE: MINI STAT (LABEL + VALOR + BORDE OPCIONAL)
// =======================
function renderMiniStat(label, value, border) {
    return `
        <div class="col-4 text-center py-3 ${border ? 'border-end' : ''}" style="border-color:rgba(255,255,255,0.08)!important;">
            <div style="font-size:0.58rem;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,0.4);font-weight:800;">${label}</div>
            <div class="fw-bold text-white" style="font-size:1.05rem;font-family:'Montserrat',sans-serif;">${value}</div>
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

    // MINIATURAS (INDICADORES)
    const indicatorsHtml = images.map((img, index) => `
        <button type="button"
                data-bs-target="#${carouselId}"
                data-bs-slide-to="${index}"
                class="${index === 0 ? 'active' : ''}"
                style="width:58px;height:44px;padding:0;border-radius:8px;overflow:hidden;background:#000;
                       border:2px solid ${index === 0 ? '#ffc107' : 'rgba(255,255,255,0.15)'};
                       transition:border-color 0.2s;flex-shrink:0;">
            <img src="${img.url}"
                 class="w-100 h-100"
                 style="object-fit:cover;opacity:${index === 0 ? '1' : '0.65'};"
                 alt="Miniatura ${index + 1}">
        </button>
    `).join('');

    // SLIDES DEL CAROUSEL
    const itemsHtml = images.map((img, index) => `
        <div class="carousel-item ${index === 0 ? 'active' : ''}">
            <img src="${img.url}"
                 class="d-block w-100"
                 alt="${animalName}"
                 style="aspect-ratio:4/3;object-fit:cover;object-position:center;border-radius:14px;">
        </div>
    `).join('');

    // ESTRUCTURA FINAL CAROUSEL
    return `
        <div style="background:#0d1117;border-radius:16px;overflow:hidden;border:1px solid rgba(255,255,255,0.06);">
            <div id="${carouselId}" class="carousel slide" data-bs-ride="false">
                <div class="carousel-inner">
                    ${itemsHtml}
                </div>
                ${images.length > 1 ? `
                <button class="carousel-control-prev" type="button" data-bs-target="#${carouselId}" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon p-3 rounded-circle" style="background:rgba(0,0,0,0.55);"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#${carouselId}" data-bs-slide="next">
                    <span class="carousel-control-next-icon p-3 rounded-circle" style="background:rgba(0,0,0,0.55);"></span>
                </button>
                ` : ''}
            </div>
            ${images.length > 1 ? `
            <div class="d-flex gap-2 px-3 py-2 overflow-x-auto" style="background:rgba(0,0,0,0.3);">
                ${indicatorsHtml}
            </div>
            ` : ''}
        </div>
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