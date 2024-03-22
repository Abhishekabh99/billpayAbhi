import 'package:billpe/views/bill/bill_router.dart';
import 'package:billpe/views/profile/store_profile_router.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../controllers/profile_controller.dart';
import '../../../model/profileResponse/store.dart';
import '../../../model/profileResponse/user.dart';
import '../../../service/local_storage.dart';

class StoreNewBillComponent extends StatefulWidget {
  const StoreNewBillComponent({super.key});

  @override
  State<StoreNewBillComponent> createState() => _StoreNewBillComponentState();
}

class _StoreNewBillComponentState extends State<StoreNewBillComponent> {
  final ProfileController _profileController = ProfileController();
  User? _user;
  Store? _store;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final token = LocalStorage.getToken()!;
      final data = await _profileController.fetchProfileData(token);

      setState(() {
        _user = _profileController.parseUserData(data);
        _store = _profileController.parseStoreData(data);
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              context.push(StoreProfilePath.storeProfile);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffA150F2),
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Color(0xffA150F2),
                    offset: Offset(-3, -3),
                  ),
                ],
              ),
              height: 140,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/store.png",
                    height: 90,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(_store?.shopName ?? "")
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              context.push(BillPath.addBill);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              height: 140,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/bill_white.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "New Bill",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
