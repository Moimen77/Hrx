from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle


ROOT = Path(__file__).resolve().parents[2]
OUTPUT_DIR = ROOT / "output" / "pdf"
OUTPUT_PDF = OUTPUT_DIR / "hrx_app_summary.pdf"


def build_story():
    styles = getSampleStyleSheet()
    title = ParagraphStyle(
        "Title",
        parent=styles["Title"],
        fontName="Helvetica-Bold",
        fontSize=20,
        leading=23,
        textColor=colors.HexColor("#17324D"),
        spaceAfter=4,
    )
    subtitle = ParagraphStyle(
        "Subtitle",
        parent=styles["BodyText"],
        fontName="Helvetica",
        fontSize=8.5,
        leading=10,
        textColor=colors.HexColor("#546375"),
        spaceAfter=8,
    )
    section = ParagraphStyle(
        "Section",
        parent=styles["Heading2"],
        fontName="Helvetica-Bold",
        fontSize=10,
        leading=12,
        textColor=colors.white,
        backColor=colors.HexColor("#1F5F8B"),
        borderPadding=(4, 6, 4),
        spaceBefore=3,
        spaceAfter=5,
    )
    body = ParagraphStyle(
        "Body",
        parent=styles["BodyText"],
        fontName="Helvetica",
        fontSize=8.4,
        leading=10.1,
        textColor=colors.HexColor("#1F2933"),
        spaceAfter=3,
    )
    bullet = ParagraphStyle(
        "Bullet",
        parent=body,
        leftIndent=10,
        firstLineIndent=0,
        bulletIndent=0,
        spaceAfter=2,
    )

    left = []
    left.append(Paragraph("HRX App Summary", title))
    left.append(
        Paragraph(
            "Repo-based, one-page overview of the Flutter application in this workspace.",
            subtitle,
        )
    )

    left.append(Paragraph("What It Is", section))
    left.append(
        Paragraph(
            "HRX is a Flutter HR management app with separate employee and HR flows. "
            "It combines authentication, attendance, leave workflows, people records, "
            "notifications, and PDF-based document viewing in one mobile-focused codebase.",
            body,
        )
    )

    left.append(Paragraph("Who It's For", section))
    left.append(
        Paragraph(
            "Primary users are HR staff and employees in the same organization, with role-based home screens and feature access.",
            body,
        )
    )

    left.append(Paragraph("What It Does", section))
    feature_items = [
        "Authenticates users with Supabase and supports password reset via deep links.",
        "Routes HR users and employees into different home screens and workflows.",
        "Tracks attendance with branch and shift selection plus geolocation-based check-in validation.",
        "Supports leave, permission, substitute, loan, and manager response flows.",
        "Lets HR manage employees, departments, branches, shifts, bonuses, penalties, and holidays.",
        "Stores employee documents in Supabase Storage and previews PDFs inside the app.",
        "Sends Firebase Cloud Messaging notifications for events such as attendance activity.",
    ]
    left.extend([Paragraph(item, bullet, bulletText="-") for item in feature_items])

    right = []
    right.append(Paragraph("How It Works", section))
    right.append(
        Paragraph(
            "<b>UI and state:</b> Feature modules live under <b>lib/modules</b>. "
            "GetX provides routing, bindings, dependency injection, and controllers.",
            body,
        )
    )
    right.append(
        Paragraph(
            "<b>App startup:</b> <b>main.dart</b> initializes Supabase, Firebase, shared services, and FCM background handling. "
            "The splash flow uses deep links plus SharedPreferences flags to route users to onboarding, login, HR home, or employee home.",
            body,
        )
    )
    right.append(
        Paragraph(
            "<b>Data flow:</b> Views -> GetX controllers -> repositories/services -> Supabase tables, RPC functions, Storage, and Firebase services.",
            body,
        )
    )
    right.append(
        Paragraph(
            "<b>Backends in repo:</b> Supabase handles auth, tables, views, RPC calls, edge functions, and file storage. "
            "Firebase is configured for app init and Cloud Messaging. SharedPreferences stores session and onboarding flags.",
            body,
        )
    )
    right.append(
        Paragraph(
            "<b>Not found in repo:</b> A backend architecture diagram, environment setup guide, or documented API contract.",
            body,
        )
    )

    right.append(Paragraph("How To Run", section))
    run_items = [
        "Install Flutter SDK. Exact version-management/setup steps are Not found in repo.",
        "From the project root, run: <b>flutter pub get</b>.",
        "Launch the app with: <b>flutter run</b>.",
        "Firebase options are checked in for Android and iOS; web and desktop Firebase configs are marked unsupported in the generated options file.",
        "Any required Supabase project provisioning, secrets rotation, or emulator/local-backend workflow is Not found in repo.",
    ]
    right.extend([Paragraph(item, bullet, bulletText="-") for item in run_items])

    sources = [
        Paragraph("Repo evidence used", section),
        Paragraph(
            "main.dart; routes/app_routes.dart and routes/app_pages.dart; auth, attendance, branch, document, homepage, and FCM service files; pubspec.yaml; firebase_options.dart; README.md.",
            body,
        ),
    ]

    table = Table(
        [[left, right]],
        colWidths=[87 * mm, 87 * mm],
        hAlign="LEFT",
    )
    table.setStyle(
        TableStyle(
            [
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("LEFTPADDING", (0, 0), (-1, -1), 0),
                ("RIGHTPADDING", (0, 0), (-1, -1), 8),
                ("TOPPADDING", (0, 0), (-1, -1), 0),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 0),
            ]
        )
    )

    story = [table, Spacer(1, 6), *sources]
    return story


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    doc = SimpleDocTemplate(
        str(OUTPUT_PDF),
        pagesize=A4,
        leftMargin=13 * mm,
        rightMargin=13 * mm,
        topMargin=11 * mm,
        bottomMargin=10 * mm,
    )

    def paint_background(canvas, _doc):
        canvas.saveState()
        canvas.setFillColor(colors.HexColor("#F4F8FB"))
        canvas.rect(0, 0, A4[0], A4[1], stroke=0, fill=1)
        canvas.setStrokeColor(colors.HexColor("#C8D8E8"))
        canvas.setLineWidth(0.8)
        canvas.line(13 * mm, A4[1] - 34 * mm, A4[0] - 13 * mm, A4[1] - 34 * mm)
        canvas.restoreState()

    doc.build(build_story(), onFirstPage=paint_background)
    print(OUTPUT_PDF)


if __name__ == "__main__":
    main()
