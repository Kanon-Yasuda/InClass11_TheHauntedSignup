// 🎛️ State field — true = dots, false = letters
bool _obscurePassword = true;

TextFormField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: const Icon(Icons.lock),
    border: const OutlineInputBorder(),
    suffixIcon: IconButton(
      icon: Icon(_obscurePassword
          ? Icons.visibility
          : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    ),
  ),
)

// State fields — add near your controllers
DateTime? _birthDate;
final _dateController = TextEditingController();

TextFormField(
  controller: _dateController,
  readOnly: true,  // taps open the picker, not the keyboard
  decoration: const InputDecoration(
    labelText: 'Birth Date',
    prefixIcon: Icon(Icons.cake),
    border: OutlineInputBorder(),
  ),
  validator: (_) => _birthDate == null
      ? 'Pick your birth date' : null,
  onTap: () async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),  // no future birthdays!
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _dateController.text =
            '${picked.month}/${picked.day}/${picked.year}';
      });
    }
  },
)

// State field
bool _submitting = false;

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _submitting = true);  // potion starts brewing

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;  // user may have left the screen

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => SuccessScreen(
          userName: _nameController.text.trim()),
    ),
  );
}

// The Sign Up button:
ElevatedButton(
  onPressed: _submitting ? null : _submit,  // null = disabled
  child: _submitting
      ? const SizedBox(
          width: 20, height: 20,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: Colors.white))
      : const Text('Join the Mansion',
            style: TextStyle(fontSize: 18)),
)