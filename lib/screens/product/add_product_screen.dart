import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isAuction = false;
  String _selectedCategory = 'إلكترونيات';
  String _selectedCity = 'صنعاء';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'إضافة إعلان جديد'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Image Upload Area
              const Text('صور المنتج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildAddImageButton(),
                    ...List.generate(3, (index) => _buildImageThumbnail(index)),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 2. Product Details
              _buildTextField('عنوان الإعلان', Icons.title, 'مثال: آيفون 15 برو ماكس'),
              _buildTextField('وصف المنتج', Icons.description, 'اكتب تفاصيل المنتج هنا...', maxLines: 4),
              
              Row(
                children: [
                  Expanded(child: _buildTextField('السعر', Icons.money, '0.00', keyboardType: TextInputType.number)),
                  const SizedBox(width: 15),
                  Expanded(child: _buildDropdown('المدينة', _selectedCity, ['صنعاء', 'عدن', 'تعز', 'إب', 'حضرموت'], (v) => setState(() => _selectedCity = v!))),
                ],
              ),
              
              _buildDropdown('الفئة', _selectedCategory, ['إلكترونيات', 'عقارات', 'سيارات', 'أزياء', 'خدمات'], (v) => setState(() => _selectedCategory = v!)),

              const SizedBox(height: 20),
              
              // 3. Auction Toggle
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.goldPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('عرض كمزاد', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('سيتمكن المستخدمون من المزايدة على السعر', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    Switch(
                      value: _isAuction,
                      onChanged: (v) => setState(() => _isAuction = v),
                      activeColor: AppColors.goldPrimary,
                    ),
                  ],
                ),
              ),

              if (_isAuction)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: _buildTextField('تاريخ انتهاء المزاد', Icons.calendar_today, 'اختر التاريخ'),
                ),

              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text('نشر الإعلان الآن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.goldPrimary),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.goldPrimary)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: const Icon(Icons.list, color: AppColors.goldPrimary),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
      ),
      child: const Icon(Icons.add_a_photo, color: Colors.grey, size: 30),
    );
  }

  Widget _buildImageThumbnail(int index) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage('https://picsum.photos/seed/add$index/200/200'), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          radius: 12,
          backgroundColor: Colors.red.withOpacity(0.8),
          child: const Icon(Icons.close, color: Colors.white, size: 14),
        ),
      ),
    );
  }

  void _handleSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text('تم نشر إعلانك بنجاح! سيتم مراجعته ونشره خلال دقائق.', textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً', style: TextStyle(color: AppColors.goldPrimary))),
        ],
      ),
    );
  }
}
