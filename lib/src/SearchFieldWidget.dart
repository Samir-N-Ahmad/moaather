import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatTextField extends StatefulWidget {
  final ValueChanged<String> onSend;
  final VoidCallback? onAttach;
  final String hintText;
  final int maxLines;
  final bool enterToSend; // desktop/web behavior

  const ChatTextField({
    super.key,
    required this.onSend,
    this.onAttach,
    this.hintText = "Message",
    this.maxLines = 6,
    this.enterToSend = true,
  });

  @override
  State<ChatTextField> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool get _canSend => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _send() {
    final msg = _controller.text.trim();
    if (msg.isEmpty) return;

    widget.onSend(msg);
    _controller.clear();
    _focusNode.requestFocus();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (!widget.enterToSend) return KeyEventResult.ignored;

    // Only handle on desktop/web keyboards
    final isEnter =
        event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.numpadEnter;

    if (!isEnter) return KeyEventResult.ignored;

    // If Shift+Enter => newline
    final isShift =
        HardwareKeyboard.instance.logicalKeysPressed.contains(
          LogicalKeyboardKey.shiftLeft,
        ) ||
        HardwareKeyboard.instance.logicalKeysPressed.contains(
          LogicalKeyboardKey.shiftRight,
        );

    if (event is KeyDownEvent && !isShift) {
      _send();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final bg = scheme.surfaceContainerHighest;
    final border = scheme.outlineVariant;
    final hint = scheme.onSurfaceVariant;
    final text = scheme.onSurface;

    // Send button style: active vs inactive
    final sendBg = _canSend ? scheme.primary : scheme.surfaceContainerHighest;
    final sendFg = _canSend ? scheme.onPrimary : scheme.onSurfaceVariant;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attach button
              IconButton(
                onPressed: widget.onAttach,
                icon: const Icon(Icons.add_rounded),
                color: scheme.onSurfaceVariant,
                tooltip: "Attach",
              ),

              // Text field (auto grow)
              Expanded(
                child: Focus(
                  focusNode: _focusNode,
                  onKeyEvent: _onKey,
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: widget.maxLines,
                    textInputAction: widget.enterToSend
                        ? TextInputAction.newline
                        : TextInputAction.send,
                    style: TextStyle(color: text, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: hint),
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Send button
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: _canSend ? _send : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sendBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: _canSend ? scheme.primary : border,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: sendFg,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
