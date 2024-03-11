import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/widgets/textfield_widget.dart';

class AddingPage extends StatefulWidget {
  final Product? product;
  final Function(Product) onProductSubmitted;
  final int list_size;

  AddingPage(
      {Key? key,
      this.product,
      required this.onProductSubmitted,
      required this.list_size})
      : super(key: key);

  @override
  _AddingPageState createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  final globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // Initialize text controllers with product data if available
    _titleController = TextEditingController();
    _imageUrlController = TextEditingController();
    _priceController = TextEditingController();
    _categoryController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose text controllers to avoid memory leaks
    _titleController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFieldWidget(
                lText: 'Title',
                hiText: 'Enter Title',
                inputType: TextInputType.text,
                controll: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                lText: 'Image URL',
                hiText: 'Enter URL',
                inputType: TextInputType.url,
                controll: _imageUrlController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter URL';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                lText: 'Category',
                hiText: 'Enter Category',
                inputType: TextInputType.text,
                controll: _categoryController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                lText: 'Description',
                hiText: 'Enter Description',
                inputType: TextInputType.text,
                controll: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                lText: 'Price',
                hiText: 'Enter Price',
                inputType: TextInputType.number,
                controll: _priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Create a new product object with the updated data
                  //Category category = Category(name: _categoryController.text);
                  if (globalKey.currentState!.validate()) {
                    Category category = CategoryExtension.fromString(
                            _categoryController.text) ??
                        Category.ELECTRONICS;
                    final addProduct = Product(
                        id: widget.list_size + 1,
                        title: _titleController.text,
                        price: double.tryParse(_priceController.text) ?? 0,
                        image: _imageUrlController.text,
                        category: category,
                        rating: Rating(rate: 0, count: 0),
                        description: _descriptionController.text);

                    // Call the onProductSubmitted callback with the updated product
                    widget.onProductSubmitted(addProduct);

                    // Navigate back to the previous screen
                    Get.back();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
