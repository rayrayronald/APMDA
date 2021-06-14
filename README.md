# my_app

A new Flutter project.

## Potential Bugs and fixes

CanvasKit memory leak
When the exception was thrown, this was the stack:  https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 150:56              Ma https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 220:103             d https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 1:1                 Paragraph$layout lib/_engine/engine/canvaskit/text.dart 572:18                                layout packages/flutter/src/painting/text_painter.dart 578:5                        layout

Solution: run with --web-renderer html to force choose html over CanvasKit
