class Menu{

  List<String> _options;
  String _prompt;

  Menu({required List<String> options, required String prompt}) 
  : _options = options,
    _prompt = prompt;


  @override
  String toString() {
    String result = "$_prompt\n";
    for (int i = 0; i < _options.length; i++) 
    {
      result += "${_options[i]}\n";
    }
    return result;
  }
}