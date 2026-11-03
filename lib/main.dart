import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HipoCalculaApp());
}

// ===== MODELO DE INFORME GUARDADO =====
class InformeGuardado {
  final String fecha;
  final String comunidad;
  final double precioVivienda;
  final double ahorrosTotal;
  final String viviendaTipo;
  final String viviendaUso; 
  final String perfilComprador;
  final String gradoDiscapacidad;
  final bool tieneAgencia;
  final double agenciaPct;
  final bool necesitaHipoteca;
  final double hipotecaPct;
  final double ingresosMensuales;
  final double prestamosMensuales;
  final bool esContado;
  
  final double inversionTotal;
  final double cuotaEstimada;
  final double debtRatio;
  final String viabilidadTitulo;

  InformeGuardado({
    required this.fecha,
    required this.comunidad,
    required this.precioVivienda,
    required this.ahorrosTotal,
    required this.viviendaTipo,
    required this.viviendaUso,
    required this.perfilComprador,
    required this.gradoDiscapacidad,
    required this.tieneAgencia,
    required this.agenciaPct,
    required this.necesitaHipoteca,
    required this.hipotecaPct,
    required this.ingresosMensuales,
    required this.prestamosMensuales,
    required this.inversionTotal,
    required this.cuotaEstimada,
    required this.debtRatio,
    required this.viabilidadTitulo,
    this.esContado = false,
  });
}

List<InformeGuardado> globalInformesGuardados = [];

class HipoCalculaApp extends StatelessWidget {
  const HipoCalculaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HipoCalcula',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF10B981),
          surface: Color(0xFF1E293B),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ==========================================
// PANTALLA DE INICIO (MENÚ PRINCIPAL)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          elevation: 0,
          toolbarHeight: 70.0,
          titleSpacing: 8,
          title: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFF10B981),
                radius: 18,
                child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('HipoCalcula', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    Text('Asistente Inmobiliario Inteligente', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¿Qué deseas hacer hoy?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Opcion 1: Hipoteca y gastos
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WizardScreen(modoContado: false)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF10B981), width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.calculate, color: Color(0xFF10B981), size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hipoteca y gastos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 4),
                          Text('Calcula tu hipoteca y los gastos correspondientes', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF94A3B8), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Opcion 2: Compra al contado
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WizardScreen(modoContado: true)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF818CF8), width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
                      child: const Text('💼', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Compra al contado', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 4),
                          Text('Calcula solo los gastos e impuestos de tu compra sin hipoteca', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF94A3B8), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Opcion 3: Informes
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformesListScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF334155), width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.folder_shared, color: Color(0xFF38BDF8), size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Informes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 4),
                          Text('Consulta tus informes guardados (Máx. 4)', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Color(0xFF94A3B8), size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// PANTALLA DE LISTADO DE INFORMES GUARDADOS
// ==========================================
class InformesListScreen extends StatefulWidget {
  const InformesListScreen({super.key});

  @override
  State<InformesListScreen> createState() => _InformesListScreenState();
}

class _InformesListScreenState extends State<InformesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF10B981),
              radius: 14,
              child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('HipoCalcula', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  Text('Informes Guardados (${globalInformesGuardados.length}/4)', style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
      body: globalInformesGuardados.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox, size: 64, color: Color(0xFF334155)),
                  SizedBox(height: 16),
                  Text('No hay informes guardados todavía', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalInformesGuardados.length,
              itemBuilder: (context, index) {
                final informe = globalInformesGuardados[index];
                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InformeDetalleScreen(informe: informe),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Inmueble: ${informe.precioVivienda.toInt()} €', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                              Chip(
                                label: Text(informe.esContado ? 'AL CONTADO' : informe.viabilidadTitulo, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                backgroundColor: informe.esContado
                                    ? const Color(0xFF818CF8).withValues(alpha: 0.2)
                                    : (informe.viabilidadTitulo.contains('ALTA') ? const Color(0xFF10B981).withValues(alpha: 0.2) : Colors.redAccent.withValues(alpha: 0.2)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('Región: ${informe.comunidad.toUpperCase()} | ${informe.viviendaUso == 'habitual' ? 'V. Habitual' : 'Segunda Res.'}', style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                          const Divider(height: 16, color: Color(0xFF334155)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Inversión total: ${informe.inversionTotal.toInt()} €', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                              Row(
                                children: [
                                  // Botón de Modificar (Lápiz)
                                  TextButton.icon(
                                    style: TextButton.styleFrom(foregroundColor: const Color(0xFF38BDF8), padding: EdgeInsets.zero),
                                    icon: const Icon(Icons.edit, size: 16),
                                    label: const Text('Modificar', style: TextStyle(fontSize: 12)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WizardScreen(
                                            modoContado: informe.esContado,
                                            informeAEditar: informe,
                                            indiceEdicion: index,
                                          ),
                                        ),
                                      ).then((_) => setState(() {}));
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  // Botón de Borrar (Papelera) añadido aquí
                                  TextButton.icon(
                                    style: TextButton.styleFrom(foregroundColor: Colors.redAccent, padding: EdgeInsets.zero),
                                    icon: const Icon(Icons.delete_outline, size: 16),
                                    label: const Text('Borrar', style: TextStyle(fontSize: 12)),
                                    onPressed: () {
                                      setState(() {
                                        globalInformesGuardados.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('🗑️ Informe eliminado correctamente.'),
                                          backgroundColor: Colors.redAccent,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// PANTALLA DE DETALLE DE INFORME GUARDADO
// ==========================================
class InformeDetalleScreen extends StatelessWidget {
  final InformeGuardado informe;

  const InformeDetalleScreen({super.key, required this.informe});

  double _calcularITPRateLocal() {
    if (informe.viviendaTipo == 'nueva') return 0.115;
    
    if (informe.viviendaUso == 'segunda') {
      switch (informe.comunidad) {
        case 'valencia': return 0.09;
        case 'madrid': return 0.06;
        case 'andalucia': return 0.07;
        case 'cataluna': return 0.10;
        case 'canarias': return 0.065;
        case 'pais_vasco': return 0.04;
        case 'navarra': return 0.06;
        default: return 0.08;
      }
    }

    switch (informe.comunidad) {
      case 'valencia':
        if (informe.perfilComprador == 'joven') return informe.precioVivienda <= 180000 ? 0.06 : 0.08;
        if (informe.perfilComprador == 'familia_numerosa') return 0.04;
        if (informe.perfilComprador == 'discapacidad') return informe.gradoDiscapacidad == '65_mas' ? 0.03 : 0.04;
        return 0.09;
      case 'madrid':
        if (informe.perfilComprador == 'joven' || informe.perfilComprador == 'familia_numerosa') return 0.04;
        if (informe.perfilComprador == 'discapacidad') return 0.04;
        return 0.06;
      case 'andalucia':
        if (informe.perfilComprador == 'joven' && informe.precioVivienda <= 150000) return 0.035;
        if (informe.perfilComprador == 'familia_numerosa' || informe.perfilComprador == 'discapacidad') return 0.035;
        return 0.07;
      case 'cataluna':
        if (informe.perfilComprador == 'joven' && informe.precioVivienda <= 200000) return 0.05;
        if (informe.perfilComprador == 'familia_numerosa' || informe.perfilComprador == 'discapacidad') return 0.05;
        return 0.10;
      default:
        return 0.08;
    }
  }

  String _obtenerDetalleITPLocal(double rate) {
    if (informe.viviendaTipo == 'nueva') return "Obra Nueva: IVA 10% + 1.5% AJD.";
    if (informe.viviendaUso == 'segunda') return "Segunda Residencia: Tipo general del ${(rate * 100).toStringAsFixed(1)}% sin bonificaciones.";
    
    if (informe.comunidad == 'valencia' && informe.perfilComprador == 'joven') {
      return informe.precioVivienda <= 180000 
          ? "C. Valenciana: ITP reducido del 6% para menor de 35 años (vivienda ≤180.000 €)."
          : "C. Valenciana: ITP reducido del 8% para menor de 35 años (>180.000 €).";
    }
    return "Aplicado ITP regional del ${(rate * 100).toStringAsFixed(1)}% según perfil y C.A.";
  }

  String _fmt(double num) {
    return num.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    double itpRate = _calcularITPRateLocal();
    double impuestos = informe.precioVivienda * itpRate;
    double gastosLegales = 2250;
    double inmobiliaria = informe.tieneAgencia ? (informe.precioVivienda * (informe.agenciaPct / 100)) * 1.21 : 0;
    double totalInversion = informe.precioVivienda + impuestos + gastosLegales + inmobiliaria;

    double hipotecaNecesariaEuros = max(0, totalInversion - informe.ahorrosTotal);

    bool ratioOk = informe.debtRatio <= 35;
    bool ltvOk = informe.hipotecaPct <= 80;
    double faltaAhorros80 = max(0, (informe.precioVivienda * (informe.hipotecaPct / 100)) - (informe.precioVivienda * 0.80));

    Color viabilidadColor = informe.esContado
        ? const Color(0xFF818CF8)
        : (informe.viabilidadTitulo.contains('ALTA') ? const Color(0xFF10B981) : Colors.redAccent);
    Color ltvColor = ltvOk ? const Color(0xFF10B981) : Colors.amber;
    Color ratioColor = ratioOk ? const Color(0xFF10B981) : Colors.redAccent;

    const String disclaimerText = "*Estos cálculos son orientativos calculados con los precios medio de mercado y los datos que has introducido.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF10B981),
              radius: 14,
              child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('HipoCalcula', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  Text('Detalle de Informe Guardado', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Informe de Gastos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: viabilidadColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: viabilidadColor),
                  ),
                  child: Text(informe.esContado ? 'AL CONTADO' : informe.viabilidadTitulo, style: TextStyle(color: viabilidadColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Guardado el ${informe.fecha} | Región: ${informe.comunidad.toUpperCase()} | Uso: ${informe.viviendaUso == 'habitual' ? 'Vivienda Habitual' : 'Segunda Residencia'}', style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
            const SizedBox(height: 20),

            // Desglose de Inversión
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DESGLOSE TOTAL DE LA INVERSIÓN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                  const SizedBox(height: 12),
                  _rowDetail('Precio de la vivienda', '${_fmt(informe.precioVivienda)} €'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Impuestos (${informe.viviendaTipo == 'segunda' ? 'ITP' : 'IVA+AJD'} ${(itpRate * 100).toStringAsFixed(1)}%)', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      Text('${_fmt(impuestos)} €', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                    ),
                    child: Text('ℹ️ ${_obtenerDetalleITPLocal(itpRate)}', style: const TextStyle(fontSize: 10, color: Color(0xFF34D399))),
                  ),
                  const SizedBox(height: 10),
                  _rowDetail('Notaría + Reg. + Gestoría + Tasación', '${_fmt(gastosLegales)} €', color: const Color(0xFF818CF8)),
                  if (informe.tieneAgencia) ...[
                    const SizedBox(height: 8),
                    _rowDetail('Comisión Inmobiliaria (+21% IVA)', '${_fmt(inmobiliaria)} €', color: const Color(0xFF06B6D4)),
                  ],
                  const Divider(height: 20, color: Color(0xFF334155)),
                  _rowDetail('Inversión Global Necesaria', '${_fmt(totalInversion)} €', isTotal: true),
                  const SizedBox(height: 12),
                  const Text(disclaimerText, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Color(0xFF10B981))),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (!informe.esContado) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ltvOk ? const Color(0xFF10B981).withValues(alpha: 0.5) : Colors.amber.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('FINANCIACIÓN HIPOTECARIA (LTV)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                        Text('${informe.hipotecaPct.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ltvColor)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF334155)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inversión Global (${_fmt(totalInversion)} €) - Ahorros (${_fmt(informe.ahorrosTotal)} €) = ${_fmt(hipotecaNecesariaEuros)} €', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text('Los ${_fmt(hipotecaNecesariaEuros)} € representan el ${informe.hipotecaPct.toInt()}% de financiación necesaria sobre el precio de la vivienda.', style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(height: 12, decoration: const BoxDecoration(color: Color(0xFF0F172A))),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: (informe.hipotecaPct / 100).clamp(0.0, 1.0),
                              child: Container(height: 12, decoration: BoxDecoration(color: ltvColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ltvOk ? const Color(0xFF10B981).withValues(alpha: 0.3) : Colors.amber.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        ltvOk
                            ? '🟢 ¡Zona Óptima! Estás solicitando un ${informe.hipotecaPct.toInt()}%. Te encuentras dentro del 80% que suelen exigir los bancos para concederte sus mejores condiciones.'
                            : '🟠 Atención LTV: Estás solicitando un ${informe.hipotecaPct.toInt()}%. Te faltan ${_fmt(faltaAhorros80)} € adicionales de ahorros para llegar al 80% y evitar penalizaciones de interés (TIN).',
                        style: TextStyle(fontSize: 11, color: ltvColor, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ratioOk ? const Color(0xFF334155) : Colors.redAccent.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('CAPACIDAD DE PAGO (ENDEUDAMIENTO)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                        Text('${informe.debtRatio.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ratioColor)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Cuota hipoteca estimada: ${_fmt(informe.cuotaEstimada)} €/mes (calculada con TIN del 3,5% a 30 años).', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ratioOk ? const Color(0xFF10B981).withValues(alpha: 0.3) : Colors.redAccent.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        ratioOk
                            ? '🟢 Viabilidad Alta: La cuota estimada no supera el 35% de tus ingresos y te mantienes dentro del 80% LTV. Cumples los filtros habituales.'
                            : '🔴 Riesgo de Endeudamiento: Tu ratio (${informe.debtRatio.toInt()}%) supera el 35% recomendado. Los bancos podrían rechazar la operación.',
                        style: TextStyle(fontSize: 11, color: ratioOk ? const Color(0xFF34D399) : Colors.redAccent, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF312E81), Color(0xFF0F172A)]),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.5)),
                ),
                child: Column(
                  children: [
                    const Text('¿Quieres conseguir una hipoteca con las mejores condiciones?', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('Un bróker hipotecario partner puede negociar tu perfil con los bancos sin coste inicial.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: const Color(0xFF0F172A),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('👉 Solicitar estudio hipotecario gratuito', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _rowDetail(String label, String value, {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? const Color(0xFF10B981) : Colors.white70, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 14 : 12)),
          Text(value, style: TextStyle(color: isTotal ? const Color(0xFF10B981) : (color ?? Colors.white), fontWeight: isTotal ? FontWeight.w800 : FontWeight.bold, fontSize: isTotal ? 15 : 12)),
        ],
      ),
    );
  }
}

// ==========================================
// ASISTENTE WIZARD
// ==========================================
class WizardScreen extends StatefulWidget {
  final bool modoContado;
  final InformeGuardado? informeAEditar;
  final int? indiceEdicion;

  const WizardScreen({
    super.key,
    required this.modoContado,
    this.informeAEditar,
    this.indiceEdicion,
  });

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  int currentStep = 1;

  late String comunidad;
  late String viviendaTipo; 
  late String viviendaUso; 
  late String perfilComprador; 
  late String gradoDiscapacidad; 
  bool esVpo = false;
  String vpoRegimen = 'general'; 
  
  late double precioVivienda;
  late double ahorrosTotal;
  
  late bool tieneAgencia;
  late double agenciaPct;
  
  late double ingresosMensuales;
  late double prestamosMensuales;

  @override
  void initState() {
    super.initState();
    if (widget.informeAEditar != null) {
      final inf = widget.informeAEditar!;
      comunidad = inf.comunidad;
      viviendaTipo = inf.viviendaTipo;
      viviendaUso = inf.viviendaUso;
      perfilComprador = inf.perfilComprador;
      gradoDiscapacidad = inf.gradoDiscapacidad;
      precioVivienda = inf.precioVivienda;
      ahorrosTotal = inf.ahorrosTotal;
      tieneAgencia = inf.tieneAgencia;
      agenciaPct = inf.agenciaPct;
      ingresosMensuales = inf.ingresosMensuales;
      prestamosMensuales = inf.prestamosMensuales;
    } else {
      comunidad = 'valencia';
      viviendaTipo = 'segunda'; 
      viviendaUso = 'habitual'; 
      perfilComprador = 'joven'; 
      gradoDiscapacidad = '33_64'; 
      precioVivienda = 180000;
      ahorrosTotal = 45000;
      tieneAgencia = true;
      agenciaPct = 3.0;
      ingresosMensuales = 2800;
      prestamosMensuales = 500;
    }
  }

  int get maxSteps => widget.modoContado ? 4 : 6;

  void nextStep() {
    setState(() {
      if (currentStep < maxSteps) currentStep++;
    });
  }

  void prevStep() {
    setState(() {
      if (currentStep > 1) currentStep--;
    });
  }

  String _fmt(double num) {
    return num.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  double _calcularHipotecaPctAutomatico() {
    if (widget.modoContado) return 0.0;
    double itpRate = _obtenerITPRate();
    double impuestos = precioVivienda * itpRate;
    double gastosLegales = 2250;
    double inmobiliaria = tieneAgencia ? (precioVivienda * (agenciaPct / 100)) * 1.21 : 0;
    double totalGastosCompra = impuestos + gastosLegales + inmobiliaria;
    
    double dineroUtilParaEntrada = max(0, ahorrosTotal - totalGastosCompra);
    double hipotecaNecesaria = max(0, precioVivienda - dineroUtilParaEntrada);
    
    double pctResult = (hipotecaNecesaria / precioVivienda) * 100;
    return pctResult.clamp(0.0, 100.0);
  }

  double _obtenerITPRate() {
    if (viviendaTipo == 'nueva') {
      return (esVpo && vpoRegimen == 'especial') ? 0.055 : 0.115;
    }

    if (viviendaUso == 'segunda') {
      switch (comunidad) {
        case 'valencia': return 0.09;
        case 'madrid': return 0.06;
        case 'andalucia': return 0.07;
        case 'cataluna': return 0.10;
        case 'canarias': return 0.065;
        case 'pais_vasco': return 0.04;
        case 'navarra': return 0.06;
        default: return 0.08;
      }
    }
    
    switch (comunidad) {
      case 'valencia':
        if (esVpo) return vpoRegimen == 'especial' ? 0.04 : 0.08;
        if (perfilComprador == 'joven') return precioVivienda <= 180000 ? 0.06 : 0.08;
        if (perfilComprador == 'familia_numerosa') return 0.04;
        if (perfilComprador == 'discapacidad') return gradoDiscapacidad == '65_mas' ? 0.03 : 0.04;
        return 0.09;
      case 'madrid':
        if (perfilComprador == 'joven' || perfilComprador == 'familia_numerosa' || esVpo) return 0.04;
        if (perfilComprador == 'discapacidad') return 0.04;
        return 0.06;
      case 'andalucia':
        if (perfilComprador == 'joven' && precioVivienda <= 150000) return 0.035;
        if (perfilComprador == 'familia_numerosa' || perfilComprador == 'discapacidad') return 0.035;
        return 0.07;
      case 'cataluna':
        if (perfilComprador == 'joven' && precioVivienda <= 200000) return 0.05;
        if (perfilComprador == 'familia_numerosa' || perfilComprador == 'discapacidad') return 0.05;
        return 0.10;
      default:
        return 0.08;
    }
  }

  String _obtenerDetalleITP(double rate) {
    if (viviendaTipo == 'nueva') return "Obra Nueva: IVA 10% + 1.5% AJD.";
    if (viviendaUso == 'segunda') return "Segunda Residencia: Tipo general del ${(rate * 100).toStringAsFixed(1)}% sin bonificaciones.";
    
    if (comunidad == 'valencia' && perfilComprador == 'joven') {
      return precioVivienda <= 180000 
          ? "C. Valenciana: ITP reducido del 6% para menor de 35 años (vivienda ≤180.000 €)."
          : "C. Valenciana: ITP reducido del 8% para menor de 35 años (>180.000 €).";
    }
    return "Aplicado ITP regional del ${(rate * 100).toStringAsFixed(1)}% según perfil y C.A.";
  }

  void guardarInformeActual() {
    if (widget.informeAEditar == null && globalInformesGuardados.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Has alcanzado el límite máximo de 4 informes guardados.'),
          backgroundColor: Colors.amber,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    double itpRate = _obtenerITPRate();
    double impuestos = precioVivienda * itpRate;
    double gastosLegales = 2250;
    double inmobiliaria = tieneAgencia ? (precioVivienda * (agenciaPct / 100)) * 1.21 : 0;
    double totalInversion = precioVivienda + impuestos + gastosLegales + inmobiliaria;
    
    double hipotecaPctAuto = _calcularHipotecaPctAutomatico();
    double hipotecaMonto = precioVivienda * (hipotecaPctAuto / 100);
    
    double cuotaEstimada = 0;
    if (!widget.modoContado && hipotecaMonto > 0) {
      double r = 0.035 / 12;
      double n = 360;
      cuotaEstimada = hipotecaMonto * (r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
    }
    double totalDeudas = cuotaEstimada + prestamosMensuales;
    double debtRatio = ingresosMensuales > 0 ? (totalDeudas / ingresosMensuales) * 100 : 0;

    String viabilidadTitulo = widget.modoContado ? "AL CONTADO" : (debtRatio <= 35 ? "VIABILIDAD ALTA" : "RIESGO ALTO");

    final now = DateTime.now();
    final fechaStr = "${now.day}/${now.month}/${now.year}";

    final nuevoInforme = InformeGuardado(
      fecha: fechaStr,
      comunidad: comunidad,
      precioVivienda: precioVivienda,
      ahorrosTotal: widget.modoContado ? totalInversion : ahorrosTotal,
      viviendaTipo: viviendaTipo,
      viviendaUso: viviendaUso,
      perfilComprador: perfilComprador,
      gradoDiscapacidad: gradoDiscapacidad,
      tieneAgencia: tieneAgencia,
      agenciaPct: agenciaPct,
      necesitaHipoteca: !widget.modoContado && hipotecaMonto > 0,
      hipotecaPct: hipotecaPctAuto,
      ingresosMensuales: ingresosMensuales,
      prestamosMensuales: prestamosMensuales,
      inversionTotal: totalInversion,
      cuotaEstimada: cuotaEstimada,
      debtRatio: debtRatio,
      viabilidadTitulo: viabilidadTitulo,
      esContado: widget.modoContado,
    );

    if (widget.informeAEditar != null && widget.indiceEdicion != null) {
      globalInformesGuardados[widget.indiceEdicion!] = nuevoInforme;
    } else {
      globalInformesGuardados.add(nuevoInforme);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✨ ¡Informe guardado con éxito!'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    int totalPasosConfig = widget.modoContado ? 3 : 5;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF10B981),
              radius: 14,
              child: Text('H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.modoContado ? 'Compra al contado' : 'Hipoteca y gastos', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  const Text('Asistente Inmobiliario Inteligente', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Chip(
              label: Text(
                currentStep <= totalPasosConfig ? 'Paso $currentStep de $totalPasosConfig' : 'Informe Final ⭐️',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
              ),
              backgroundColor: const Color(0xFF1E293B),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: currentStep / maxSteps.toDouble(),
            backgroundColor: const Color(0xFF1E293B),
            color: widget.modoContado ? const Color(0xFF818CF8) : const Color(0xFF10B981),
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: _buildCurrentStepView(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFF1E293B),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 1)
                  OutlinedButton(
                    onPressed: prevStep,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Anterior'),
                  )
                else
                  const SizedBox.shrink(),
                
                if (currentStep < maxSteps)
                  ElevatedButton(
                    onPressed: nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.modoContado ? const Color(0xFF818CF8) : const Color(0xFF10B981),
                      foregroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Siguiente ➔', style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: guardarInformeActual,
                    icon: const Icon(Icons.bookmark_add, size: 18),
                    label: Text(widget.informeAEditar != null ? 'Actualizar informe' : 'Guardar informe', style: const TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38BDF8),
                      foregroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCurrentStepView() {
    if (widget.modoContado) {
      switch (currentStep) {
        case 1: return _buildStep1();
        case 2: return _buildStep2();
        case 3: return _buildStep3Contado();
        case 4: return _buildStep6Results();
        default: return _buildStep1();
      }
    } else {
      switch (currentStep) {
        case 1: return _buildStep1();
        case 2: return _buildStep2();
        case 3: return _buildStep3();
        case 4: return _buildStep4();
        case 5: return _buildStep5();
        case 6: return _buildStep6Results();
        default: return _buildStep1();
      }
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('¿Dónde vas a comprar?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Selecciona la Comunidad Autónoma para aplicar automáticamente la fiscalidad correspondiente (ITP / AJD).', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 20),
        const Text('COMUNIDAD AUTÓNOMA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: comunidad,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1E293B),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF334155))),
          ),
          dropdownColor: const Color(0xFF1E293B),
          items: const [
            DropdownMenuItem(value: 'andalucia', child: Text('Andalucía')),
            DropdownMenuItem(value: 'aragon', child: Text('Aragón')),
            DropdownMenuItem(value: 'asturias', child: Text('Asturias')),
            DropdownMenuItem(value: 'baleares', child: Text('Islas Baleares')),
            DropdownMenuItem(value: 'canarias', child: Text('Canarias')),
            DropdownMenuItem(value: 'cantabria', child: Text('Cantabria')),
            DropdownMenuItem(value: 'castilla_la_mancha', child: Text('Castilla-La Mancha')),
            DropdownMenuItem(value: 'castilla_leon', child: Text('Castilla y León')),
            DropdownMenuItem(value: 'cataluna', child: Text('Cataluña')),
            DropdownMenuItem(value: 'extremadura', child: Text('Extremadura')),
            DropdownMenuItem(value: 'galicia', child: Text('Galicia')),
            DropdownMenuItem(value: 'madrid', child: Text('Comunidad de Madrid')),
            DropdownMenuItem(value: 'murcia', child: Text('Región de Murcia')),
            DropdownMenuItem(value: 'navarra', child: Text('Navarra')),
            DropdownMenuItem(value: 'pais_vasco', child: Text('País Vasco')),
            DropdownMenuItem(value: 'rioja', child: Text('La Rioja')),
            DropdownMenuItem(value: 'valencia', child: Text('Comunidad Valenciana')),
          ],
          onChanged: (val) => setState(() => comunidad = val!),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Uso, Estado y Perfil', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Indica el uso previsto, estado de la vivienda y tu perfil comprador para ajustar impuestos e hipoteca.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 20),
        
        const Text('USO DE LA VIVIENDA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
        const SizedBox(height: 8),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => viviendaUso = 'habitual'),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: viviendaUso == 'habitual' ? const Color(0xFF10B981) : const Color(0xFF334155),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🏠', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        const Text('Vivienda Habitual', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Aplica bonificaciones ITP/AJD', style: TextStyle(fontSize: 10, color: viviendaUso == 'habitual' ? const Color(0xFF10B981) : const Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => viviendaUso = 'segunda'),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: viviendaUso == 'segunda' ? const Color(0xFF818CF8) : const Color(0xFF334155),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🏖️', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        const Text('Segunda Residencia', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Tipo general sin bonificación', style: TextStyle(fontSize: 10, color: viviendaUso == 'segunda' ? const Color(0xFF818CF8) : const Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Text('ESTADO DE LA VIVIENDA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
        const SizedBox(height: 8),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => viviendaTipo = 'segunda'),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: viviendaTipo == 'segunda' ? const Color(0xFF10B981) : const Color(0xFF334155),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🏷️', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        const Text('Segunda Mano', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Impuesto de ITP', style: TextStyle(fontSize: 10, color: viviendaTipo == 'segunda' ? const Color(0xFF10B981) : const Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => viviendaTipo = 'nueva'),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: viviendaTipo == 'nueva' ? const Color(0xFF10B981) : const Color(0xFF334155),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🏗️', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 8),
                        const Text('Obra Nueva', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('IVA 10% + AJD', style: TextStyle(fontSize: 10, color: viviendaTipo == 'nueva' ? const Color(0xFF10B981) : const Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (viviendaUso == 'habitual') ...[
          const SizedBox(height: 20),
          const Text('PERFIL DEL COMPRADOR (BONIFICACIONES)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: perfilComprador,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF334155))),
            ),
            dropdownColor: const Color(0xFF1E293B),
            items: const [
              DropdownMenuItem(value: 'general', child: Text('Perfil General / Mayor de 35 años')),
              DropdownMenuItem(value: 'joven', child: Text('Menor de 35 años')),
              DropdownMenuItem(value: 'familia_numerosa', child: Text('Familia numerosa (3 hijos o +)')),
              DropdownMenuItem(value: 'discapacidad', child: Text('Persona con Discapacidad')),
            ],
            onChanged: (val) => setState(() => perfilComprador = val!),
          ),
          if (perfilComprador == 'discapacidad') ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF10B981)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Grado de Discapacidad', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: gradoDiscapacidad,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    dropdownColor: const Color(0xFF0F172A),
                    items: const [
                      DropdownMenuItem(value: '33_64', child: Text('Igual o superior al 33% (y menor de 65%)')),
                      DropdownMenuItem(value: '65_mas', child: Text('Igual o superior al 65%')),
                    ],
                    onChanged: (val) => setState(() => gradoDiscapacidad = val!),
                  ),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Precio y Ahorros', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Valores económicos base para calcular impuestos e hipoteca.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 24),
        TextFormField(
          initialValue: precioVivienda.toInt().toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: '¿CUÁNTO CUESTA LA VIVIENDA?', prefixText: '€ ', filled: true, fillColor: const Color(0xFF1E293B), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          onChanged: (val) => precioVivienda = double.tryParse(val.replaceAll(',', '.')) ?? 0,
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: ahorrosTotal.toInt().toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: '¿CUÁNTO AHORRO QUIERES APORTAR?', prefixText: '€ ', filled: true, fillColor: const Color(0xFF1E293B), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          onChanged: (val) => ahorrosTotal = double.tryParse(val.replaceAll(',', '.')) ?? 0,
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Total aportado para destinar a la entrada y los gastos.',
            style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3Contado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Precio e Inmobiliaria', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Introduce el valor de compra y los costes de intermediación.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 24),
        TextFormField(
          initialValue: precioVivienda.toInt().toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: '¿CUÁNTO CUESTA LA VIVIENDA?', prefixText: '€ ', filled: true, fillColor: const Color(0xFF1E293B), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          onChanged: (val) => precioVivienda = double.tryParse(val.replaceAll(',', '.')) ?? 0,
        ),
        const SizedBox(height: 24),
        const Text('Comisión de Inmobiliaria', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => tieneAgencia = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: tieneAgencia ? const Color(0xFF10B981) : const Color(0xFF334155),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Sí hay inmobiliaria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => tieneAgencia = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: !tieneAgencia ? const Color(0xFF10B981) : const Color(0xFF334155),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Sin inmobiliaria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        if (tieneAgencia) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('COMISIÓN DE INMOBILIARIA (%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text('%', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: agenciaPct.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          onChanged: (v) => agenciaPct = double.tryParse(v.replaceAll(',', '.')) ?? 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFF10B981), size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Se calculará el porcentaje indicado de comisión al precio total de la vivienda y se le añadirá automáticamente el 21% de IVA correspondiente.',
                        style: TextStyle(fontSize: 11, color: const Color(0xFF10B981), height: 1.3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Comisión de Inmobiliaria', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Indica si la compraventa involucra honorarios de agencia.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => tieneAgencia = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: tieneAgencia ? const Color(0xFF10B981) : const Color(0xFF334155),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Sí hay inmobiliaria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => tieneAgencia = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: !tieneAgencia ? const Color(0xFF10B981) : const Color(0xFF334155), width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Sin inmobiliaria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        if (tieneAgencia) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('COMISIÓN DE INMOBILIARIA (%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text('%', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: agenciaPct.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          onChanged: (v) => agenciaPct = double.tryParse(v.replaceAll(',', '.')) ?? 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFF10B981), size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Se calculará el porcentaje indicado de comisión al precio total de la vivienda y se le añadirá automáticamente el 21% de IVA correspondiente.',
                        style: TextStyle(fontSize: 11, color: const Color(0xFF10B981), height: 1.3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ingresos y Préstamos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Indica tus ingresos mensuales y las deudas o préstamos actuales para calcular tu capacidad de pago.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildNumberInput('Ingresos mes (Titulares)', ingresosMensuales, (val) => setState(() => ingresosMensuales = val), 100),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildNumberInput('Otros préstamos/mes', prestamosMensuales, (val) => setState(() => prestamosMensuales = val), 50),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberInput(String title, double val, Function(double) onChanged, double step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF334155))),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 12.0), child: Text('€', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold))),
              Expanded(
                child: TextFormField(
                  initialValue: val.toInt().toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  onChanged: (v) => onChanged(double.tryParse(v.replaceAll(',', '.')) ?? 0),
                ),
              ),
              Column(
                children: [
                  InkWell(onTap: () => onChanged(val + step), child: const Icon(Icons.keyboard_arrow_up, size: 18, color: Color(0xFF94A3B8))),
                  InkWell(onTap: () => onChanged(max(0, val - step)), child: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF94A3B8))),
                ],
              ),
              const SizedBox(width: 6),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep6Results() {
    double itpRate = _obtenerITPRate();
    double impuestos = precioVivienda * itpRate;
    double gastosLegales = 2250;
    double inmobiliaria = tieneAgencia ? (precioVivienda * (agenciaPct / 100)) * 1.21 : 0;
    double totalInversion = precioVivienda + impuestos + gastosLegales + inmobiliaria;

    double hipotecaPctAuto = _calcularHipotecaPctAutomatico();
    double hipotecaMonto = precioVivienda * (hipotecaPctAuto / 100);
    double hipotecaNecesariaEuros = max(0, totalInversion - ahorrosTotal);
    bool necesitaHipoteca = !widget.modoContado && hipotecaMonto > 0;
    
    double cuotaEstimada = 0;
    if (!widget.modoContado && hipotecaMonto > 0) {
      double r = 0.035 / 12;
      double n = 360;
      cuotaEstimada = hipotecaMonto * (r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
    }
    
    double totalDeudas = cuotaEstimada + prestamosMensuales;
    double debtRatio = ingresosMensuales > 0 ? (totalDeudas / ingresosMensuales) * 100 : 0;

    bool ratioOk = debtRatio <= 35;
    bool ltvOk = hipotecaPctAuto <= 80;
    double faltaAhorros80 = max(0, (precioVivienda * (hipotecaPctAuto / 100)) - (precioVivienda * 0.80));

    String viabilidadTitulo = widget.modoContado ? "COMPRA AL CONTADO" : (debtRatio <= 35 ? "VIABILIDAD ALTA" : "RIESGO ALTO");
    Color viabilidadColor = widget.modoContado ? const Color(0xFF818CF8) : (debtRatio <= 35 ? const Color(0xFF10B981) : Colors.redAccent);

    Color ltvColor = ltvOk ? const Color(0xFF10B981) : Colors.amber;
    Color ratioColor = ratioOk ? const Color(0xFF10B981) : Colors.redAccent;
    const String disclaimerText = "*Estos cálculos son orientativos calculados con los precios medio de mercado y los datos que has introducido.";

    String detalleItpTexto = _obtenerDetalleITP(itpRate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.modoContado ? 'Resumen de Compra' : 'Informe de Viabilidad', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: viabilidadColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: viabilidadColor),
              ),
              child: Text(viabilidadTitulo, style: TextStyle(color: viabilidadColor, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(widget.modoContado ? 'Gastos e impuestos detallados para tu compra sin hipoteca.' : 'Resultado integral de tu operación de compra.', style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DESGLOSE TOTAL DE LA INVERSIÓN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
              const SizedBox(height: 12),
              _rowDetail('Precio de la vivienda', '${_fmt(precioVivienda)} €'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Impuestos (${viviendaTipo == 'segunda' ? 'ITP' : 'IVA+AJD'} ${(itpRate * 100).toStringAsFixed(1)}%)', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  Text('${_fmt(impuestos)} €', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                ),
                child: Text('ℹ️ $detalleItpTexto', style: const TextStyle(fontSize: 10, color: Color(0xFF34D399))),
              ),
              const SizedBox(height: 10),
              _rowDetail('Notaría + Reg. + Gestoría + Tasación', '${_fmt(gastosLegales)} €', color: const Color(0xFF818CF8)),
              if (tieneAgencia) ...[
                const SizedBox(height: 8),
                _rowDetail('Comisión Inmobiliaria (+21% IVA)', '${_fmt(inmobiliaria)} €', color: const Color(0xFF06B6D4)),
              ],
              const Divider(height: 20, color: Color(0xFF334155)),
              _rowDetail('Inversión Global Necesaria', '${_fmt(totalInversion)} €', isTotal: true),
              const SizedBox(height: 12),
              const Text(disclaimerText, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Color(0xFF10B981))),
            ],
          ),
        ),
        const SizedBox(height: 16),

        if (!widget.modoContado) ...[
          if (necesitaHipoteca)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ltvOk ? const Color(0xFF10B981).withValues(alpha: 0.5) : Colors.amber.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('FINANCIACIÓN HIPOTECARIA (LTV)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                      Text('${hipotecaPctAuto.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ltvColor)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF334155)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inversión Global (${_fmt(totalInversion)} €) - Ahorros (${_fmt(ahorrosTotal)} €) = ${_fmt(hipotecaNecesariaEuros)} €', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text('Los ${_fmt(hipotecaNecesariaEuros)} € representan el ${hipotecaPctAuto.toInt()}% de financiación necesaria sobre el precio de la vivienda.', style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(height: 12, decoration: const BoxDecoration(color: Color(0xFF0F172A))),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: (hipotecaPctAuto / 100).clamp(0.0, 1.0),
                            child: Container(height: 12, decoration: BoxDecoration(color: ltvColor)),
                          ),
                        ),
                        Positioned.fill(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double markerPosition = constraints.maxWidth * 0.80;
                              return Stack(
                                children: [
                                  Positioned(
                                    left: markerPosition - 1.5,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 3,
                                      color: const Color(0xFFD97706),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0%', style: TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
                      Text('⚠️ Límite del 80% mejores condiciones', style: TextStyle(fontSize: 9, color: Color(0xFFD97706), fontWeight: FontWeight.bold)),
                      Text('100%', style: TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ltvOk ? const Color(0xFF10B981).withValues(alpha: 0.3) : Colors.amber.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      ltvOk
                          ? '🟢 ¡Zona Óptima! Estás solicitando un ${hipotecaPctAuto.toInt()}%. Te encuentras dentro del 80% que suelen exigir los bancos para concederte sus mejores condiciones.'
                          : '🟠 Atención LTV: Estás solicitando un ${hipotecaPctAuto.toInt()}%. Te faltan ${_fmt(faltaAhorros80)} € adicionales de ahorros para llegar al 80% y evitar penalizaciones de interés (TIN).',
                      style: TextStyle(fontSize: 11, color: ltvColor, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(disclaimerText, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: ltvColor)),
                ],
              ),
            ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ratioOk ? const Color(0xFF334155) : Colors.redAccent.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('CAPACIDAD DE PAGO (ENDEUDAMIENTO)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                    Text('${debtRatio.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ratioColor)),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Cuota hipoteca estimada: ${_fmt(cuotaEstimada)} €/mes (calculada con TIN del 3,5% a 30 años).', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ratioOk ? const Color(0xFF10B981).withValues(alpha: 0.3) : Colors.redAccent.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    ratioOk
                        ? '🟢 Viabilidad Alta: La cuota estimada no supera el 35% de tus ingresos y te mantienes dentro del 80% LTV. Cumples los filtros habituales.'
                        : '🔴 Riesgo de Endeudamiento: Tu ratio (${debtRatio.toInt()}%) supera el 35% recomendado. Los bancos podrían rechazar la operación.',
                    style: TextStyle(fontSize: 11, color: ratioOk ? const Color(0xFF34D399) : Colors.redAccent, height: 1.4),
                  ),
                ),
                const SizedBox(height: 12),
                Text(disclaimerText, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: ratioColor)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF312E81), Color(0xFF0F172A)]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                const Text('¿Quieres conseguir una hipoteca con las mejores condiciones?', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                const SizedBox(height: 6),
                const Text('Un bróker hipotecario partner puede negociar tu perfil con los bancos sin coste inicial.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('👉 Solicitar estudio hipotecario gratuito', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _rowDetail(String label, String value, {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? const Color(0xFF10B981) : Colors.white70, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 14 : 12)),
          Text(value, style: TextStyle(color: isTotal ? const Color(0xFF10B981) : (color ?? Colors.white), fontWeight: isTotal ? FontWeight.w800 : FontWeight.bold, fontSize: isTotal ? 15 : 12)),
        ],
      ),
    );
  }
}