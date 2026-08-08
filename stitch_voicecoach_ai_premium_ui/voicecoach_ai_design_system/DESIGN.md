---
name: VoiceCoach AI Design System
colors:
  surface: '#0d1321'
  surface-dim: '#0d1321'
  surface-bright: '#333948'
  surface-container-lowest: '#080e1c'
  surface-container-low: '#151b29'
  surface-container: '#191f2e'
  surface-container-high: '#242a39'
  surface-container-highest: '#2f3544'
  on-surface: '#dde2f6'
  on-surface-variant: '#c0c7d4'
  inverse-surface: '#dde2f6'
  inverse-on-surface: '#2a303f'
  outline: '#8a919d'
  outline-variant: '#404752'
  surface-tint: '#a2c9ff'
  primary: '#a2c9ff'
  on-primary: '#00315b'
  primary-container: '#4da3ff'
  on-primary-container: '#003866'
  inverse-primary: '#0060a9'
  secondary: '#c6bfff'
  on-secondary: '#2900a0'
  secondary-container: '#4029ba'
  on-secondary-container: '#b4abff'
  tertiary: '#ffb95c'
  on-tertiary: '#462a00'
  tertiary-container: '#de8f00'
  on-tertiary-container: '#4f3000'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d3e4ff'
  primary-fixed-dim: '#a2c9ff'
  on-primary-fixed: '#001c38'
  on-primary-fixed-variant: '#004881'
  secondary-fixed: '#e4dfff'
  secondary-fixed-dim: '#c6bfff'
  on-secondary-fixed: '#160066'
  on-secondary-fixed-variant: '#4029ba'
  tertiary-fixed: '#ffddb7'
  tertiary-fixed-dim: '#ffb95c'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#0d1321'
  on-background: '#dde2f6'
  surface-variant: '#2f3544'
typography:
  display-score:
    fontFamily: Inter
    fontSize: 64px
    fontWeight: '700'
    lineHeight: 72px
    letterSpacing: -0.04em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-padding: 24px
  gutter: 16px
  stack-sm: 12px
  stack-md: 24px
  stack-lg: 40px
---

## Brand & Style

The design system is engineered for a high-performance, professional coaching environment. It targets executives, public speakers, and professionals who demand a tool that feels like a premium utility rather than a toy. The brand personality is authoritative yet motivating, characterized by extreme precision and a quiet confidence.

The visual style employs a **refined Modern Corporate** aesthetic with **subtle Glassmorphism**. It prioritizes data clarity and high-end finishes, utilizing deep backgrounds to make critical insights and performance metrics pop. Every interaction should feel intentional, avoiding unnecessary decorative elements to maintain a focus on the user's progress and vocal data.

## Colors

The palette is anchored in a deep, nocturnal foundation to minimize visual fatigue and elevate the premium feel.

- **Primary & Accent:** A sophisticated interplay between "Signal Blue" (#4DA3FF) for primary actions and "Vocal Purple" (#6C5CE7) for secondary brand moments and progress indicators.
- **Surface Strategy:** The background remains at #0B0F1A. Elevated containers and cards use #121826 to create depth without relying on heavy borders.
- **Functional Colors:** Success, Warning, and Error states use desaturated, professional tones to ensure they integrate seamlessly into the dark UI without appearing jarring or neon.

## Typography

This design system utilizes **Inter** for its systematic, utilitarian precision. The typographic hierarchy is designed to highlight performance data.

- **Data Heroics:** The `display-score` style is reserved for AI-generated scores and metrics, using heavy weights and tight letter-spacing to command attention.
- **Readability:** Body text maintains a generous line height to ensure coaching feedback is easily digestible.
- **Scalability:** Large headlines transition to `headline-lg-mobile` on smaller viewports to prevent awkward text wrapping while maintaining visual impact.

## Layout & Spacing

The layout philosophy follows a **fluid grid** model with a focus on generous internal margins to evoke a sense of "luxury space."

- **Margins:** A standard 24px margin on mobile devices ensures content does not feel cramped against the bezel.
- **Stacking:** Use the 8px base unit for all spatial relationships. `stack-md` (24px) is the default vertical rhythm between distinct content blocks.
- **Safe Areas:** Adhere strictly to mobile safe areas, ensuring that primary action buttons (like "Start Session") are positioned within easy thumb reach but clear of system indicators.

## Elevation & Depth

Hierarchy is established through **Tonal Layers** and **Subtle Glassmorphism**.

- **Z-Index 0:** The base background (#0B0F1A).
- **Z-Index 1 (Cards):** Surface cards (#121826) with a 1px low-contrast border (10% white) to define edges.
- **Z-Index 2 (Overlays/Modals):** Semi-transparent surfaces using a 70% opacity of the surface color and a 20px backdrop blur. This creates the "frosted" high-end feel characteristic of premium OS interfaces.
- **Shadows:** Avoid heavy black shadows. Use soft, ambient glows that inherit a slight tint of the primary color (#4DA3FF) at 5-10% opacity for floating elements like the "Record" button.

## Shapes

The shape language is sophisticated and consistent. 

- **Containers:** All primary cards and modals use a 16px radius (`rounded-lg`), providing a modern, approachable yet professional structure.
- **Interactive Elements:** Buttons use a slightly more aggressive rounding or full pills to distinguish them from content containers. 
- **Consistency:** Avoid mixing sharp corners with rounded ones. All interactive states, including focus rings and selection indicators, must follow the 16px baseline.

## Components

- **Buttons:** Primary buttons use a solid #4DA3FF fill with white text. Secondary buttons use a "Ghost" style with a 1px border. No gradients; use solid, confident colors.
- **Cards:** Used for coaching insights and session history. Ensure 24px internal padding. Content should be left-aligned, with scores positioned in the top right.
- **Input Fields:** Darker than the card surface (#080B12) with a subtle 1px border. Focus state is a 2px outer glow of #4DA3FF.
- **Voice Visualizers:** Use clean, thin line-based waveforms. Avoid "bubbly" or thick bars. Use the accent purple (#6C5CE7) for active recording states.
- **Progress Rings:** Use thin, high-precision strokes for AI metrics. Percentages should be rendered in `label-md` or `display-score` depending on the container size.
- **Lists:** Clean separation using 1px dividers at 5% white opacity. No chevrons unless the list item is explicitly navigable.