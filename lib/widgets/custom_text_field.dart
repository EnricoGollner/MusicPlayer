import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool enableInteractiveSelection;
  final bool enableButtonCleanValue;
  final VoidCallback? cleanValueAditionalFunction;
  final VoidCallback? onPressedSuffixIcon;
  final String? label;
  final TextStyle? labelTextStyle;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixicon;
  final Function(String)? onChanged;
  final bool autocorrect;
  final bool enableSuggestions;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isOntapClear;
  final FocusNode? focusNode;
  final bool isAutoFocus;
  final Function()? onPressed;
  final bool isFilled;
  final bool isWhite;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool handleDecimal;
  final int? handleDecimalRange;

  const CustomTextField({
    super.key,
    this.enableInteractiveSelection = true,
    this.enableButtonCleanValue = false,
    this.cleanValueAditionalFunction,
    this.onPressedSuffixIcon,
    this.label,
    this.labelTextStyle,
    this.enabled = true,
    required this.hintText,
    this.prefixIcon,
    this.suffixicon,
    this.onChanged,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.height,
    this.controller,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.isPassword = false,
    this.isOntapClear = false,
    this.focusNode,
    this.isAutoFocus = false,
    this.onPressed,
    this.isFilled = true,
    this.isWhite = false,
    this.onEditingComplete,
    this.onTapOutside,
    this.handleDecimal = false,
    this.handleDecimalRange,
    this.textCapitalization,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    ///Necessário para checar se o campo perdeu o foco
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.label != null,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.label ?? '',
                  style: widget.labelTextStyle,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            onEditingComplete: widget.onEditingComplete,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            enabled: widget.enabled,
            contextMenuBuilder: (context, editableTextState) => widget.enableInteractiveSelection
              ? AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState)
              : const SizedBox(),
            enableInteractiveSelection: widget.enableInteractiveSelection,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            autofocus: widget.isAutoFocus,
            onTap: widget.isOntapClear
                ? clearTextField
                : () => () {},
            onFieldSubmitted: widget.onFieldSubmitted,
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            controller: widget.controller,
            validator: widget.validatorFunction,
            inputFormatters: widget.inputFormatters,
            obscureText: _obscureText,
            // style: textFieldStyle,
            decoration: InputDecoration(
              counterText: '',
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2.5),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              // errorStyle: errorStyle,
              errorMaxLines: 2,
              // prefixIcon: widget.prefixIcon != null
              //     ? BoxIcon(
              //         iconData: widget.prefixIcon!,
              //         color: colorSecondary,
              //       )
              //     : null,
              // prefixIconConstraints: BoxConstraints.tight(Size(60, 20.s)),
              // suffixIcon: _buildSufixIconWidget(),
              suffixIconConstraints: BoxConstraints.tight(const Size(60, 25)),
              filled: widget.isFilled,
              hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              hintText: widget.hintText,
              fillColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ],
    );
  }
  
  // Widget? _buildSufixIconWidget() {
  //   return widget.isPassword
  //     ? GestureDetector(
  //       onTap: () => setState(() => _obscureText = !_obscureText),
  //       child: BoxIcon(
  //             iconData: _obscureText ? Icons.visibility : Icons.visibility_off,
  //             color: colorPrimary,
  //           ),
  //     )
  //     : widget.enableButtonCleanValue
  //       ? GestureDetector(
  //           onTap: clearTextField,
  //           child: BoxIcon(
  //             iconData: Icons.clear,
  //             color: colorLabelHint.withOpacity(0.4),
  //           ),
  //         )
  //       : widget.suffixicon != null ? GestureDetector(
  //           onTap: widget.onPressedSuffixIcon,
  //           child: BoxIcon(
  //             iconData: widget.suffixicon!,
  //             color: colorSecondary,
  //           ),
  //         ) : null;
  // }

  ///Método para limpar os valores inseridos no textfield e executar a ação customizada caso seja passada como parâmetro
  void clearTextField() {
    widget.controller!.clear();
    widget.cleanValueAditionalFunction?.call();
  }
}
