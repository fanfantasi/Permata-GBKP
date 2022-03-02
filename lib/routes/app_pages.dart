import 'package:anggota/views/components/pdf_viewer_page.dart';
import 'package:anggota/views/pages/auth/resert.dart';
import 'package:anggota/views/pages/auth/signin.dart';
import 'package:anggota/views/pages/auth/signup.dart';
import 'package:anggota/views/pages/bukup3rt/pemesananp3rt.dart';
import 'package:anggota/views/pages/bukupa/bukupa.dart';
import 'package:anggota/views/pages/bukupa/tahunbuku.dart';
import 'package:anggota/views/pages/dashboard/dashboard.dart';
import 'package:anggota/views/pages/dashboard/dashboard_binding.dart';
import 'package:anggota/views/pages/hapus/formhapus.dart';
import 'package:anggota/views/pages/home/edit.dart';
import 'package:anggota/views/pages/home/informasi.dart';
import 'package:anggota/views/pages/home/tabkeanggotaan.dart';
import 'package:anggota/views/pages/home/verifikasi.dart';
import 'package:anggota/views/pages/pembayaran/konfirmasi.dart';
import 'package:anggota/views/pages/pembayaran/metode.dart';
import 'package:anggota/views/pages/pembayaran/pembayaran.dart';
import 'package:anggota/views/pages/pemesanan/pemesanan.dart';
import 'package:anggota/views/pages/pindah/formpindah.dart';
import 'package:anggota/views/pages/profile/changeprofile.dart';
import 'package:anggota/views/pages/profile/password.dart';
import 'package:anggota/views/pages/splash/splashscreen.dart';
import 'package:anggota/views/pages/splash/welcome.dart';
import 'package:anggota/views/pages/upload/upload.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(
        name: AppRoutes.home,
        page: () => const DashboardPage(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoutes.signin,
        page: () => const SignInPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.resert,
        page: () => const ResertPage(),
        transition: Transition.native),
    GetPage(name: AppRoutes.signup, page: () => const SignUpPage()),
    GetPage(
        name: AppRoutes.tabanggota,
        page: () => const TabKeanggotaan(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.informasi,
        page: () => const InformasiScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.verifikasi,
        page: () => const VerifikasiScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.editanggota,
        page: () => const EditScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.formpindah,
        page: () => const FormPindahPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.formhapus,
        page: () => const FormHapusPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.bukupa,
        page: () => const BukupaPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.tahunbuku,
        page: () => const TahunBukuPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.viewpdf,
        page: () => const PDFViewerPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.pemesanan,
        page: () => const PemesananPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.pemesananp3rt,
        page: () => const PemesananP3RTPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.pembayaran,
        page: () => const PembayaranPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.konfirmasi,
        page: () => const KonfirmasiPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.metode,
        page: () => const MetodePage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.confirmasi,
        page: () => const KonfirmasiPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.upload,
        page: () => const UploadPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.password,
        page: () => const PasswordPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.changeprofile,
        page: () => const ChangeProfile(),
        transition: Transition.cupertino),
  ];
}
