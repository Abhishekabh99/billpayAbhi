import 'package:billpe/features/bill/bill_notifier.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewBillComponent extends StatelessWidget {
  const NewBillComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final refWatch = ref.watch(addBillNotifierProvider);
        final refRead = ref.read(addBillNotifierProvider.notifier);
        return Wrap(
          children: refWatch.value
                  ?.map(
                    (e) => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            refRead.markBillActive(refWatch.value?.indexOf(e));
                          },
                          child: Card(
                            color:
                                e.isActive ? AppColors.primary : Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.0,
                                right: refWatch.value?.length == 1 ? 16 : 40,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${e.billName} ${e.billNumber}",
                                    style: TextStyle(
                                      color: e.isActive
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: refWatch.value?.indexOf(e) ==
                                            (refWatch.value?.length ?? 0) - 1
                                        ? 16
                                        : 0,
                                  ),
                                  refWatch.value?.indexOf(e) ==
                                          (refWatch.value?.length ?? 0) - 1
                                      ? InkWell(
                                          onTap: () {
                                            refRead.addBill(
                                                (refWatch.value?.length ?? 0) +
                                                    1);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                        refWatch.value?.length == 1
                            ? const SizedBox()
                            : Positioned.fill(
                                child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    refRead.removeBill(
                                        refWatch.value?.indexOf(e) ?? 0);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                      ],
                    ),
                  )
                  .toList() ??
              [],
        );
      },
    );
  }
}
