import 'package:flutter/material.dart';
import 'package:billpe/model/addProductResponse/add_product_response.dart';
import 'package:billpe/network/app_product_api.dart';
import 'package:billpe/service/local_storage.dart';
import 'package:billpe/model/searchProductResponse/product.dart';

class AddProductScreen extends StatefulWidget {
  final Product? selectedProduct;

  const AddProductScreen({Key? key, this.selectedProduct}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productSizeController = TextEditingController();
  TextEditingController _barcodeController = TextEditingController();
  TextEditingController _unitController = TextEditingController();
  TextEditingController _mrpController = TextEditingController();
  TextEditingController _retailController = TextEditingController();
  TextEditingController _wholesaleStockController = TextEditingController();
  TextEditingController _lowStockAlertController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _subCategoryController = TextEditingController();
  TextEditingController _hsnController = TextEditingController();
  TextEditingController _gstController = TextEditingController();
  TextEditingController _cessController = TextEditingController();

  bool _showAdditionalDetails = false;
  bool _mrpIncludesGST = false;
  bool _addToInventory = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedProduct != null) {
      _productNameController.text = widget.selectedProduct!.productName ?? '';
      _productSizeController.text = widget.selectedProduct!.packageWeight ?? '';
      _barcodeController.text = widget.selectedProduct!.barcode ?? '';
      _unitController.text = widget.selectedProduct!.unit ?? '';
      _mrpController.text = widget.selectedProduct!.mrp?.toString() ?? '';
      _retailController.text =
          widget.selectedProduct!.retailPrice?.toString() ?? '';
      _wholesaleStockController.text =
          widget.selectedProduct!.stock?.toString() ?? '';
      _lowStockAlertController.text =
          widget.selectedProduct!.lowStock?.toString() ?? '';
      _brandController.text = widget.selectedProduct!.brand ?? '';
      _categoryController.text = widget.selectedProduct!.category ?? '';
      _subCategoryController.text = widget.selectedProduct!.category ?? '';
      _hsnController.text = widget.selectedProduct!.hsn ?? '';
      _gstController.text = widget.selectedProduct!.gst?.toString() ?? '';
      _cessController.text = widget.selectedProduct!.cess?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.selectedProduct != null &&
                  widget.selectedProduct!.productImage != null)
                Image.network(
                  widget.selectedProduct!.productImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 24),
              _buildRow(
                'Product Name',
                'Package Size',
                _productNameController,
                _productSizeController,
              ),
              SizedBox(height: 16),
              _buildRow(
                'Barcode',
                'Unit',
                _barcodeController,
                _unitController,
              ),
              SizedBox(height: 16),
              _buildCheckBox(
                'MRP includes GST',
                _mrpIncludesGST,
                (value) {
                  setState(() {
                    _mrpIncludesGST = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildRow(
                'MRP',
                'Retail Price',
                _mrpController,
                _retailController,
              ),
              SizedBox(height: 16),
              _buildRow(
                'Wholesale Stock',
                'Low Stock Alert',
                _wholesaleStockController,
                _lowStockAlertController,
              ),
              SizedBox(height: 16),
              _buildCheckBox(
                'Add to Inventory',
                _addToInventory,
                (value) {
                  setState(() {
                    _addToInventory = value!;
                  });
                },
              ),
              _buildAdditionalDetailsButton(),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _showAdditionalDetails,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow(
                      'Brand',
                      'Category',
                      _brandController,
                      _categoryController,
                    ),
                    SizedBox(height: 16),
                    _buildRow(
                      'Sub Category',
                      'HSN',
                      _subCategoryController,
                      _hsnController,
                    ),
                    SizedBox(height: 16),
                    _buildRow(
                      'GST',
                      'CESS',
                      _gstController,
                      _cessController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add variant button action
                    },
                    child: Text(
                      'Add Variant',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cancel button
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveProduct(); // Save button
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build a row with two text fields
  Widget _buildRow(String label1, String label2,
      TextEditingController controller1, TextEditingController controller2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller1,
            decoration: InputDecoration(
              labelText: label1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller2,
            decoration: InputDecoration(
              labelText: label2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build a row with a checkbox
  Widget _buildCheckBox(String text, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(text),
      ],
    );
  }

  // Method to build the button for toggling additional details
  Widget _buildAdditionalDetailsButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _showAdditionalDetails = !_showAdditionalDetails;
            });
          },
          child: Text(
            _showAdditionalDetails
                ? 'Hide Additional Details'
                : 'Show Additional Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

// Method to save product
  void _saveProduct() async {
    if (_productNameController.text.isEmpty || _unitController.text.isEmpty) {
      _showErrorDialog('Product name and unit are required.');
      return;
    }

    if (_mrpController.text.isNotEmpty) {
      if (!isNumeric(_mrpController.text)) {
        _showErrorDialog('MRP must be a valid number.');
        return;
      }
    }

    if (_retailController.text.isNotEmpty) {
      if (!isNumeric(_retailController.text)) {
        _showErrorDialog('Retail price must be a valid number.');
        return;
      }
    }

    if (_wholesaleStockController.text.isNotEmpty) {
      if (!isNumeric(_wholesaleStockController.text)) {
        _showErrorDialog('Wholesale stock must be a valid number.');
        return;
      }
    }

    if (_lowStockAlertController.text.isNotEmpty) {
      if (!isNumeric(_lowStockAlertController.text)) {
        _showErrorDialog('Low stock alert must be a valid number.');
        return;
      }
    }

    final Product product = Product(
      productName: _productNameController.text,
      packageWeight: _productSizeController.text,
      barcode: _barcodeController.text,
      unit: _unitController.text,
      mrp: double.tryParse(_mrpController.text),
      retailPrice: double.tryParse(_retailController.text),
      //stock is being used inplace of wholesale stock
      stock: int.tryParse(_wholesaleStockController.text),
      lowStock: int.tryParse(_lowStockAlertController.text),
      // Add other fields as needed
    );

    try {
      final Map<String, dynamic> response =
          await AddProductApi.postProduct(product, LocalStorage.getToken()!);
      final AddProductResponse apiResponse =
          AddProductResponse.fromJson(response);
      if (apiResponse.success) {
        // Product added successfully
        print('Product added: ${apiResponse.message}');
        Navigator.pop(context);
      } else {
        // Show error message
        _showErrorDialog(apiResponse.message);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('Failed to post product. Please try again later.');
    }
  }

// Method to check if a string is numeric
  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

// Method to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
