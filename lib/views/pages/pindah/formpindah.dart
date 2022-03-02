import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/pages/pindah/pindah_controller.dart';
import 'package:anggota/views/widgets/focusnode.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormPindahPage extends StatefulWidget {
  const FormPindahPage({Key? key}) : super(key: key);

  @override
  State<FormPindahPage> createState() => _FormPindahPageState();
}

class _FormPindahPageState extends State<FormPindahPage> {
  final _formKey = GlobalKey<FormState>();
  final PindahController pindahController = Get.put(PindahController());

  @override
  void initState() {
    super.initState();
    () {
      getData().then((value) {
        if (value) {
          pindahController.getRunggun();
          pindahController.alasan.value = 'Bekerja';
          pindahController.selectedDate = DateTime.now();
        }
      });
    }();
  }

  Future<bool> getData() async {
    pindahController.clearData();
    return pindahController.getKlasis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajukan Pindah Keanggotaan'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Obx(() => (pindahController.loadingedit.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFieldContainer(
                      color: Colors.white,
                      child: TextFormField(
                        controller: pindahController.tglController,
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
                          value: pindahController.klasis.value,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.check_box,
                              color: kPrimaryColor,
                            ),
                            labelText: 'Klasis',
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
                            pindahController.klasis.value = newValue.toString();
                            int i = pindahController.listklasis.indexWhere(
                                (element) => element.klasis == newValue);
                            pindahController.klasisid.value =
                                pindahController.listklasis[i].id.toString();
                            await pindahController.getRunggun();
                          },
                          items: pindahController.listklasis.map((p) {
                            return DropdownMenuItem(
                              child: Text(
                                p.klasis,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              value: p.klasis,
                            );
                          }).toList(),
                        ),
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
                          value: pindahController.runggun.value,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.check_box,
                              color: kPrimaryColor,
                            ),
                            labelText: 'Runggun',
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
                            pindahController.runggun.value =
                                newValue.toString();
                            int i = pindahController.listrunggun.indexWhere(
                                (element) => element.runggun == newValue);
                            pindahController.runggunid.value =
                                pindahController.listrunggun[i].id.toString();
                          },
                          items: pindahController.listrunggun.map((p) {
                            return DropdownMenuItem(
                              child: Text(
                                p.runggun,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              value: p.runggun,
                            );
                          }).toList(),
                        ),
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
                          value: pindahController.alasan.value,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.check_box,
                              color: kPrimaryColor,
                            ),
                            labelText: 'Alasan Pindah',
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
                            pindahController.alasan.value = newValue.toString();
                          },
                          items: <String>[
                            'Bekerja',
                            'Sekolah',
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
                        controller: pindahController.nosuratController,
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
                        controller: pindahController.remarksController,
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        maxLines: null,
                        validator: RequiredValidator(
                            errorText: 'Harap isi Keterangan'),
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
                      () => (pindahController.submit.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : RoundedButton(
                              text: "SUBMIT",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  pindahController.submitPindah();
                                }
                              },
                            ),
                    )
                  ],
                ),
              )),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: pindahController.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != pindahController.selectedDate) {
      setState(() {
        pindahController.selectedDate = picked;
        pindahController.tglController.text =
            DateFormat('d MMM y').format(picked);
      });
    }
  }
}
