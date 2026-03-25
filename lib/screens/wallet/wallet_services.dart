import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/wallet_provider.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class WalletServiceScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> fields;

  const WalletServiceScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.fields,
  });

  @override
  State<WalletServiceScreen> createState() => _WalletServiceScreenState();
}

class _WalletServiceScreenState extends State<WalletServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;
  String _selectedCurrency = 'YER';

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      _controllers[field] = TextEditingController();
    }
    if (!widget.fields.contains('المبلغ')) {
      _controllers['المبلغ'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: widget.title, showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Info
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.goldPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.goldPrimary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('رصيدك الحالي:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      _selectedCurrency == 'YER'
                          ? '${wallet.yerBalance.toStringAsFixed(0)} ر.ي'
                          : _selectedCurrency == 'SAR'
                              ? '${wallet.sarBalance.toStringAsFixed(0)} ر.س'
                              : '${wallet.usdBalance.toStringAsFixed(0)} \$',
                      style: const TextStyle(color: AppColors.goldPrimary, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Currency Selector
              const Text('اختر العملة', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: ['YER', 'SAR', 'USD'].map((curr) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(curr),
                        selected: _selectedCurrency == curr,
                        onSelected: (selected) {
                          if (selected) setState(() => _selectedCurrency = curr);
                        },
                        selectedColor: AppColors.goldPrimary,
                        labelStyle: TextStyle(color: _selectedCurrency == curr ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Dynamic Fields
              ...widget.fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _controllers[field],
                    keyboardType: field == 'المبلغ' || field.contains('رقم') ? TextInputType.number : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: field,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(_getIconForField(field)),
                    ),
                    validator: (value) => value!.isEmpty ? 'يرجى إدخال $field' : null,
                  ),
                );
              }),

              if (!widget.fields.contains('المبلغ'))
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _controllers['المبلغ'],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'المبلغ',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.money),
                    ),
                    validator: (value) => value!.isEmpty ? 'يرجى إدخال المبلغ' : null,
                  ),
                ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleProcess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('تأكيد ${widget.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForField(String field) {
    if (field.contains('رقم')) return Icons.numbers;
    if (field.contains('اسم')) return Icons.person_outline;
    if (field.contains('ملاحظات')) return Icons.note_alt_outlined;
    if (field.contains('المبلغ')) return Icons.attach_money;
    return Icons.edit_note;
  }

  Future<void> _handleProcess() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final amount = double.tryParse(_controllers['المبلغ']!.text) ?? 0;
      final wallet = Provider.of<WalletProvider>(context, listen: false);
      
      final success = await wallet.processTransaction(
        serviceName: widget.title,
        amount: amount,
        currency: _selectedCurrency,
        details: _controllers.map((key, value) => MapEntry(key, value.text)),
      );

      setState(() => _isLoading = false);

      if (success && mounted) {
        _showSuccessDialog();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('عذراً، الرصيد غير كافٍ أو حدث خطأ في العملية'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تمت العملية بنجاح!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('تم تنفيذ طلب ${widget.title} بنجاح. سيتم تحديث رصيدك فوراً.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to wallet
            },
            child: const Text('حسناً', style: TextStyle(color: AppColors.goldPrimary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Service Factory for all 22 services
class WalletServiceFactory {
  static Widget getServiceScreen(String serviceName) {
    switch (serviceName) {
      case 'إيداع':
        return const WalletServiceScreen(title: 'إيداع رصيد', icon: Icons.add_circle_outline, fields: ['رقم الحساب', 'اسم المودع', 'المبلغ']);
      case 'تحويل':
        return const WalletServiceScreen(title: 'تحويل مالي', icon: Icons.swap_horiz, fields: ['رقم حساب المستلم', 'اسم المستلم', 'المبلغ', 'ملاحظات']);
      case 'سحب':
        return const WalletServiceScreen(title: 'سحب نقدي', icon: Icons.remove_circle_outline, fields: ['رقم الفرع / الوكيل', 'المبلغ', 'كلمة السر']);
      case 'دفع فواتير':
        return const WalletServiceScreen(title: 'دفع فواتير', icon: Icons.receipt_long, fields: ['رقم الفاتورة', 'نوع الخدمة', 'المبلغ']);
      case 'خدمات ترفيه':
        return const WalletServiceScreen(title: 'خدمات ترفيه', icon: Icons.tv, fields: ['اسم الخدمة (Netflix/OSN)', 'رقم الحساب', 'المبلغ']);
      case 'ألعاب':
        return const WalletServiceScreen(title: 'شحن ألعاب', icon: Icons.videogame_asset, fields: ['ID اللاعب', 'نوع اللعبة (PUBG/FreeFire)', 'المبلغ']);
      case 'تطبيقات':
        return const WalletServiceScreen(title: 'شراء تطبيقات', icon: Icons.apps, fields: ['اسم التطبيق', 'رقم الهاتف', 'المبلغ']);
      case 'بطائق نت':
        return const WalletServiceScreen(title: 'بطائق إنترنت', icon: Icons.wifi_tethering, fields: ['نوع البطاقة', 'الكمية', 'المبلغ']);
      case 'أمازون':
        return const WalletServiceScreen(title: 'بطائق أمازون', icon: Icons.shopping_bag, fields: ['فئة البطاقة (\$)', 'البريد الإلكتروني', 'المبلغ']);
      case 'بنوك ومحافظ':
        return const WalletServiceScreen(title: 'تحويل لبنك/محفظة', icon: Icons.account_balance, fields: ['اسم البنك', 'رقم الحساب/الهاتف', 'المبلغ']);
      case 'تحويلات مالية':
        return const WalletServiceScreen(title: 'تحويلات مالية', icon: Icons.money, fields: ['اسم المستلم الرباعي', 'رقم الهاتف', 'المبلغ']);
      case 'مدفوعات حكومية':
        return const WalletServiceScreen(title: 'مدفوعات حكومية', icon: Icons.account_balance_wallet, fields: ['رقم المعاملة', 'الجهة الحكومية', 'المبلغ']);
      case 'فلكسي':
        return const WalletServiceScreen(title: 'فلكسي', icon: Icons.bolt, fields: ['رقم المشترك', 'المبلغ']);
      case 'سحب نقدي':
        return const WalletServiceScreen(title: 'سحب نقدي', icon: Icons.atm, fields: ['رقم الصراف', 'المبلغ', 'كود السحب']);
      case 'تعليم عالي':
        return const WalletServiceScreen(title: 'رسوم جامعية', icon: Icons.school, fields: ['رقم الطالب', 'اسم الجامعة', 'المبلغ']);
      case 'الشحن والسداد':
        return const WalletServiceScreen(title: 'شحن وسداد', icon: Icons.local_shipping, fields: ['رقم الشحنة', 'المبلغ']);
      case 'شحن الرصيد':
        return const WalletServiceScreen(title: 'شحن رصيد هاتف', icon: Icons.phone_android, fields: ['رقم الهاتف', 'الشبكة (يمن موبايل/سبأفون)', 'المبلغ']);
      case 'سداد باقات':
        return const WalletServiceScreen(title: 'سداد باقات', icon: Icons.inventory_2, fields: ['رقم الهاتف', 'نوع الباقة', 'المبلغ']);
      case 'إنترنت وهاتف':
        return const WalletServiceScreen(title: 'إنترنت وهاتف ثابت', icon: Icons.router, fields: ['رقم الهاتف الثابت', 'المبلغ']);
      case 'استلام حوالة':
        return const WalletServiceScreen(title: 'استلام حوالة', icon: Icons.call_received, fields: ['رقم الحوالة (MTN)', 'رقم الهاتف', 'المبلغ المتوقع']);
      case 'العمليات':
        return const WalletServiceScreen(title: 'سجل العمليات', icon: Icons.history, fields: ['بحث بالتاريخ', 'نوع العملية']);
      case 'طلب حوالة':
        return const WalletServiceScreen(title: 'طلب حوالة', icon: Icons.send_and_archive, fields: ['رقم هاتف المرسل', 'المبلغ المطلوب']);
      default:
        return const WalletServiceScreen(title: 'خدمة فلكس', icon: Icons.star, fields: ['المبلغ']);
    }
  }
}
