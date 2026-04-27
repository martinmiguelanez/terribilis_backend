/**
 * admin.js - Gestión integral del formulario de administración
 */

window.initAdminLogic = async function() {
    console.log("Admin Logic: Inicializando sistema...");
    
    // 1. Precarga de Tablas Maestras (Ajustado a las rutas de tu MasterController)
	// 1. Cargamos los datos iniciales
    await Promise.all([
		loadMasterCheckboxes('/api/Food', 'food-list', 'food'),
        loadMasterSelect('/api/TaxonomicClass', 'add-classId'), 
        loadMasterSelect('/api/DietTypes', 'diet-type-id'),
        loadMasterCheckboxes('/api/HealthIssue', 'health-list', 'health'),
        loadSupplementsForForm()
    ]);

    // 2. Lógica de Cascada para Taxonomía (AÑADE ESTO AQUÍ)
    const classSelect = document.getElementById('add-classId');
    const orderSelect = document.getElementById('add-orderId');
    const familySelect = document.getElementById('add-familyId');

    classSelect.addEventListener('change', async () => {
        const classId = classSelect.value;
        if (!classId) return;
        
        // Cargamos órdenes filtrados por clase
        await loadMasterSelect(`/api/TaxonomicOrder`, 'add-orderId', classId, 'taxonomicClass');
        orderSelect.disabled = false;
        familySelect.disabled = true;
        familySelect.innerHTML = '<option value="">Seleccione Orden...</option>';
    });

    orderSelect.addEventListener('change', async () => {
        const orderId = orderSelect.value;
        if (!orderId) return;

        // Cargamos familias filtradas por orden
        await loadMasterSelect(`/api/TaxonomicFamily`, 'add-familyId', orderId, 'taxonomicOrder');
        familySelect.disabled = false;
    });

    // 2. Configuración del validador de Bootstrap y el evento Submit
    const form = document.getElementById('speciesForm');
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        if (!form.checkValidity()) {
            e.stopPropagation();
            form.classList.add('was-validated');
            alert("Por favor, rellena los campos obligatorios marcados en rojo.");
            return;
        }

        await sendMegaJsonToBackend();
    });
};

// --- FUNCIONES DE PRECARGA ---

async function loadMasterSelect(endpoint, elementId, filterId = null, filterParam = null) {
    try {
        // Si hay filtro, añadimos el query param
        let url = endpoint;
        if (filterId && filterParam) {
            url += `?${filterParam}Id=${filterId}`; 
        }

        const res = await fetch(url);
        if (!res.ok) throw new Error("Error en la red");
        
        const data = await res.json();
        const select = document.getElementById(elementId);
        if (!select) return;

        select.innerHTML = '<option value="" disabled selected>Seleccionar...</option>' + 
            data.map(item => `<option value="${item.id}">${item.nombre}</option>`).join('');
    } catch (e) { 
        console.error(`Error en select ${elementId}:`, e); 
    }
}

async function loadMasterCheckboxes(endpoint, containerId, prefix) {
    try {
        const res = await fetch(endpoint);
        const data = await res.json();
        const container = document.getElementById(containerId);
        
        // Determinamos el placeholder según el prefijo para evitar confusiones
        const placeholder = prefix === 'health' ? 'Nota de prevención...' : 'Notas nutricionales...';
        // Determinamos el ID del input: 'prev-' para salud, 'dietnotes-' para comida
        const inputIdPrefix = prefix === 'health' ? 'prev-' : 'dietnotes-';

        container.innerHTML = data.map(item => `
            <div class="col-md-6 mb-2">
                <div class="p-2 border rounded bg-white shadow-sm h-100">
                    <div class="form-check">
                        <input class="form-check-input ${prefix}-check" type="checkbox" value="${item.id}" id="${prefix}-${item.id}">
                        <label class="form-check-label fw-bold small d-block" for="${prefix}-${item.id}">
                            ${item.nombre}
                        </label>
                        <div class="text-muted" style="font-size: 0.7rem; line-height: 1.1;">
                            ${item.descripcion || 'Sin descripción disponible.'}
                        </div>
                    </div>
                    <input type="text" class="form-control form-control-sm mt-2 d-none ${prefix}-obs" 
                           id="${inputIdPrefix}${item.id}" placeholder="${placeholder}">
                </div>
            </div>
        `).join('');

        // Lógica de mostrar/ocultar ajustada al nuevo ID dinámico
        container.querySelectorAll(`.${prefix}-check`).forEach(cb => {
            cb.addEventListener('change', (e) => {
                const obsInput = document.getElementById(`${inputIdPrefix}${e.target.value}`);
                if (obsInput) obsInput.classList.toggle('d-none', !e.target.checked);
            });
        });
    } catch (e) { console.error(`Error en checkboxes ${containerId}:`, e); }
}

async function loadSupplementsForForm() {
    const container = document.getElementById('admin-supplement-list');
    try {
        const res = await fetch('/api/Supplement'); // Ajustado a tu MasterController
        const data = await res.json();
        container.innerHTML = data.map(s => `
            <div class="col-md-6">
                <div class="p-2 border rounded bg-light">
                    <div class="form-check">
                        <input class="form-check-input supp-check" type="checkbox" value="${s.id}" id="supp-${s.id}">
                        <label class="form-check-label small fw-bold" for="supp-${s.id}">${s.nombre}</label>
                    </div>
                    <input type="text" class="form-control form-control-sm mt-1 supp-obs" id="obs-supp-${s.id}" placeholder="Pauta...">
                </div>
            </div>
        `).join('');
    } catch (e) { console.error("Error en suplementos:", e); }
}

// --- CONSTRUCCIÓN DEL MEGA-JSON ---

async function sendMegaJsonToBackend() {
    const getSafeValue = (id) => document.getElementById(id) ? document.getElementById(id).value : "";
    const getSafeChecked = (id) => document.getElementById(id) ? document.getElementById(id).checked : false;

    // --- CORRECCIÓN DE SALUD ---
    const selectedHealth = Array.from(document.querySelectorAll('.health-check:checked')).map(cb => ({
        healthIssue: { id: parseInt(cb.value) },
        prevencion: document.getElementById(`prev-${cb.value}`)?.value || ""
    }));

    // --- CORRECCIÓN DE ALIMENTOS (Si quieres que guarden notas individuales por insecto) ---
    const selectedFoods = Array.from(document.querySelectorAll('.food-check:checked')).map(cb => ({
        food: { id: parseInt(cb.value) },
        // Si tu tabla diet_foods tiene columna observaciones, descomenta la siguiente línea:
        // observaciones: document.getElementById(`dietnotes-${cb.value}`)?.value || ""
    }));

    const selectedSupplements = Array.from(document.querySelectorAll('.supp-check:checked')).map(cb => ({
        supplement: { id: parseInt(cb.value) },
        observaciones: document.getElementById(`obs-supp-${cb.value}`)?.value || ""
    }));

    const sustratos = Array.from(document.querySelectorAll('.check-sustrato:checked')).map(cb => cb.value).join(', ');
    const decoraciones = Array.from(document.querySelectorAll('.check-decor:checked')).map(cb => cb.value).join(', ');
    const enriquecimientos = Array.from(document.querySelectorAll('.check-enriq:checked')).map(cb => cb.value).join(', ');

    const speciesDto = {
        nombreComun: getSafeValue('add-nombreComun'),
        nombreCientifico: getSafeValue('add-nombreCientifico'),
        descripcion: getSafeValue('add-descripcion'),
        dificultad: getSafeValue('add-dificultad'),
        actividad: getSafeValue('add-actividad'),
        peligrosidad: getSafeValue('add-peligrosidad'),
        esperanzaVida: parseInt(getSafeValue('add-vida')) || 0,
        tamanoPromedioCm: getSafeValue('add-tamano'), // Mantenlo como String si quieres el "60x45x30"
        pesoPromedioGramos: parseInt(getSafeValue('add-peso')) || 0,
        
        taxonomicFamily: { id: parseInt(getSafeValue('add-familyId')) || null },

        environment: {
            temperaturaDiaMin: parseFloat(getSafeValue('env-tDiaMin')) || 0,
            temperaturaDiaMax: parseFloat(getSafeValue('env-tDiaMax')) || 0,
            temperaturaNocheMin: parseFloat(getSafeValue('env-tNocheMin')) || 0,
            temperaturaNocheMax: parseFloat(getSafeValue('env-tNocheMax')) || 0,
            humedadMin: parseFloat(getSafeValue('env-hMin')) || 0,
            humedadMax: parseFloat(getSafeValue('env-hMax')) || 0,
            horasLuz: parseInt(getSafeValue('env-horas')) || 12,
            uvbRequerido: getSafeValue('env-uvb') === 'true'
        },

        habitat: {
            tipo: getSafeValue('hab-tipo'),
            tamanoMinimoCm: getSafeValue('hab-size'), 
            volumenLitros: parseInt(getSafeValue('hab-litros')) || 0,
            sustrato: sustratos,
            decoracion: decoraciones,
            enriquecimiento: enriquecimientos
        },

        naturalHabitat: {
            region: getSafeValue('nat-region'),
            clima: getSafeValue('nat-clima'),
            bioma: getSafeValue('nat-bioma'),
            altitud: getSafeValue('nat-altitud')
        },

        brumation: {
            requiere: getSafeChecked('bru-req'),
            meses: getSafeValue('bru-meses'),
            temperaturaMin: parseFloat(getSafeValue('bru-tMin')) || 0,
            temperaturaMax: parseFloat(getSafeValue('bru-tMax')) || 0,
            descripcion: getSafeValue('bru-desc')
        },

        diets: [{
            dietType: { id: parseInt(getSafeValue('diet-type-id')) || null },
            frecuencia: getSafeValue('diet-frecuencia'),
            observaciones: getSafeValue('diet-obs'), // <--- LAS NOTAS GENERALES DE DIETA VAN AQUÍ
            dietFoods: selectedFoods
        }],

        supplements: selectedSupplements,
        healthIssues: selectedHealth,
        
        images: getSafeValue('add-imgUrl') ? [{ 
            url: getSafeValue('add-imgUrl'), 
            descripcion: "Imagen Principal" 
        }] : []
    };

    console.log("JSON Final listo:", speciesDto);

    try {
        const response = await fetch('/api/especies', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(speciesDto)
        });

        if (response.ok) {
            alert("¡Ficha guardada correctamente!");
            location.reload();
        } else {
            const errorText = await response.text();
            alert("Error: " + errorText);
        }
    } catch (error) {
        console.error("Error POST:", error);
    }
}