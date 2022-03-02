import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/pages/hapus/hapus_controller.dart';
import 'package:anggota/views/widgets/focusnode.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormHapusPage extends StatefulWidget {
  const FormHapusPage({Key? key}) : super(key: key);

  @override
  State<FormHapusPage> createState() => _FormHapusPageState();
}

class _FormHapusPageState extends State<FormHapusPage> {
  final _formKey = GlobalKey<FormState>();
  final HapusController hapusController = Get.put(HapusController());

  @override
  void initState() {
    super.initState();
    hapusController.clearData();
    hapusController.alasan.value = 'Meninggal Dunia';
    hapusController.selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ajukan Hapus Keanggotaan'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFieldContainer(
                    color: Colors.white,
                    child: TextFormField(
                      controller: hapusController.tglController,
                      cursorColor: kPrimaryColor,
                      validator:
                          RequiredValidator(errorText: 'Harap isi Tanggal'),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.date_range,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Tanggal',
                        hintText: 'Tanggal',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                      focusNode: AlwaysDisabledFocusNode(),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  Obx(
                    () => TextFieldContainer(
                      color: Colors.white,
                      child: DropdownButtonFormField(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF777777),
                        ),
                        value: hapusController.alasan.value,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.check_box,
                            color: kPrimaryColor,
                          ),
                          labelText: 'Alasan Hapus',
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 16),
                          hintStyle: TextStyle(color: Colors.black54),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE2E2E2),
                              width: .5,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE2E2E2),
                              width: .5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE2E2E2),
                              width: .5,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE2E2E2),
                              width: .5,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE2E2E2),
                              width: .5,
                            ),
                          ),
                        ),
                        onChanged: (newValue) async {
                          hapusController.alasan.value = newValue.toString();
                        },
                        items: <String>[
                          'Meninggal Dunia',
                          'Keluar dari GBKP',
                          'Menikah',
                          'Lain-Lain',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: Colors.white,
                    child: TextFormField(
                      controller: hapusController.nosuratController,
                      cursorColor: kPrimaryColor,
                      autofocus: false,
                      validator:
                          RequiredValidator(errorText: 'Harap isi No. Surat'),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.note,
                          color: kPrimaryColor,
                        ),
                        labelText: 'No. Surat',
                        hintText: 'No. Surat',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: Colors.white,
                    child: TextFormField(
                      controller: hapusController.remarksController,
                      cursorColor: kPrimaryColor,
                      autofocus: false,
                      maxLines: null,
                      validator:
                          RequiredValidator(errorText: 'Harap isi Keterangan'),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Keterangan',
                        hintText: 'Keterangan',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Obx(
                    () => (hapusController.submit.value)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RoundedButton(
                            text: "SUBMIT",
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                hapusController.submitHapus();
                              }
                            },
                          ),
                  )
                ],
              ),
            )));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: hapusController.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != hapusController.selectedDate) {
      setState(() {
        hapusController.selectedDate = picked;
        hapusController.tglController.text =
            DateFormat('d MMM y').format(picked);
      });
    }
  }
}
