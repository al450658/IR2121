import os
import glob
from PIL import Image
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Image as RLImage, Spacer, PageBreak

def crear_pdf_mapas(nombre_pdf="mapas_slam.pdf"):
    # Buscar todos los archivos .pgm en el directorio actual
    archivos_pgm = glob.glob("map*.pgm")
    
    if not archivos_pgm:
        print("No se encontraron archivos .pgm con el patrón 'map*.pgm'")
        return

    # Ordenamiento natural basado en el número dentro del nombre (ej. map2 antes que map10)
    def extraer_numero(nombre):
        import re
        numeros = re.findall(r'\d+', nombre)
        return int(numeros[-1]) if numeros else 0

    archivos_pgm.sort(key=extraer_numero)
    
    print(f"Se encontraron {len(archivos_pgm)} mapas ordenados. Generando PDF...")

    # Configurar el documento PDF (márgenes estrechos para aprovechar más espacio)
    doc = SimpleDocTemplate(nombre_pdf, pagesize=letter, leftMargin=30, rightMargin=30, topMargin=30, bottomMargin=30)
    story = []

    for i, archivo in enumerate(archivos_pgm):
        try:
            img = Image.open(archivo)
            temp_img_path = f"temp_{i}.png"
            img.save(temp_img_path, "PNG")
            
            # Ajustar tamaño de la imagen para que encaje bien en la página (ancho máximo ~520 puntos)
            img_w, img_h = img.size
            max_width = 520
            aspect = img_h / img_w
            display_w = max_width
            display_h = max_width * aspect
            
            # Si es muy alta, limitar también la altura para que no desborde la página
            if display_h > 700:
                display_h = 700
                display_w = 700 / aspect

            story.append(RLImage(temp_img_path, width=display_w, height=display_h))
            
            # Añadir un salto de página entre mapa y mapa (quita la línea de abajo si prefieres que vayan seguidos)
            story.append(PageBreak())
            
        except Exception as e:
            print(f"Error procesando {archivo}: {e}")

    # Construir el PDF
    doc.build(story)
    
    # Limpiar imágenes temporales PNG
    for i in range(len(archivos_pgm)):
        temp_file = f"temp_{i}.png"
        if os.path.exists(temp_file):
            os.remove(temp_file)

    print(f"¡PDF generado con éxito: {nombre_pdf}!")

if __name__ == "__main__":
    crear_pdf_mapas()
