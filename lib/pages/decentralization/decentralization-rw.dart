import "package:flutter/material.dart";
import 'package:ralga/utils/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DecentralizationRW extends StatefulWidget {
  const DecentralizationRW({Key? key}) : super(key: key);

  @override
  State<DecentralizationRW> createState() => _DecentralizationRWState();
}

enum _Year { y2001, y2012, y2021 }

class _DecentralizationRWState extends State<DecentralizationRW> {
  _Year selectedYear = _Year.y2012;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // PDF view controller + loading/error state
  final PdfViewerController _pdfController = PdfViewerController();
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  int _loadAttempt = 0; // bump to force SfPdfViewer to rebuild on retry

  // NOTE: only the 2012 PDF URL was present in the original file.
  // 2001 and 2021 URLs follow the same naming convention used by the
  // EN screen (kinyarwanda_decentralization_{year}.pdf) — update if the
  // actual hosted filenames differ.
  static const Map<_Year, String> _pdfUrls = {
    _Year.y2001:
        'https://drive.google.com/file/d/1Zk7ycJUsSwaE19S1WYHY9VSUAlmC7sJL/view',
    _Year.y2012:
        'https://drive.google.com/file/d/1Zk7ycJUsSwaE19S1WYHY9VSUAlmC7sJL/view',
    _Year.y2021:
        'https://drive.google.com/file/d/1Zk7ycJUsSwaE19S1WYHY9VSUAlmC7sJL/view',
  };

  //   static const Map<_Year, String> _pdfUrls = {
  //   _Year.y2001:
  //       'https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2001.pdf',
  //   _Year.y2012:
  //       'https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2012.pdf',
  //   _Year.y2021:
  //       'https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2021.pdf',
  // };

  String get _currentUrl => _pdfUrls[selectedYear]!;

  void _selectYear(_Year year) {
    if (selectedYear == year) return;
    setState(() {
      selectedYear = year;
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
      _loadAttempt++;
    });
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
      _loadAttempt++;
    });
  }

  PreferredSizeWidget _appBar(double height) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, height + 150),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [appDarkColor, appDarkColor.withOpacity(0.85)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios,
                                color: whiteColor),
                          ),
                          const Expanded(
                            child: Text(
                              "Ubuyobozi Bwegereye Abaturage",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(_currentUrl);
                      },
                      icon: const Icon(Icons.share, color: whiteColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _yearChip("2001", _Year.y2001),
                    const SizedBox(width: 10),
                    _yearChip("2012", _Year.y2012),
                    const SizedBox(width: 10),
                    _yearChip("2021", _Year.y2021),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yearChip(String label, _Year year) {
    final bool isSelected = selectedYear == year;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _selectYear(year),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 64,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? appColor : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Umwaka",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? appColor : Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isSelected ? appColor : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPdfArea() {
    return Stack(
      children: [
        // The actual PDF viewer (kept alive even during overlay states so
        // SfPdfViewer's own progressive rendering keeps working).
        SfPdfViewer.network(
          _currentUrl,
          key: ValueKey('${_currentUrl}_$_loadAttempt'),
          controller: _pdfController,
          canShowPaginationDialog: true,
          onDocumentLoaded: (details) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _hasError = false;
            });
          },
          onDocumentLoadFailed: (details) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = details.description.isNotEmpty
                  ? details.description
                  : "Ntibyashobotse gufungura iyi nyandiko.";
            });
          },
        ),

        // Loading overlay
        if (_isLoading && !_hasError)
          Container(
            color: whiteColor,
            child: const _PdfLoadingIndicator(),
          ),

        // Error overlay
        if (_hasError)
          Container(
            color: whiteColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 56,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Ntibyashobotse gufungura iyi nyandiko",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Ongera ugerageze"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        foregroundColor: whiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: whiteColor,
      body: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildPdfArea(),
        ),
      ),
    );
  }
}

/// Animated loading state shown while the PDF document is being
/// downloaded/parsed by SfPdfViewer.
class _PdfLoadingIndicator extends StatefulWidget {
  const _PdfLoadingIndicator();

  @override
  State<_PdfLoadingIndicator> createState() => _PdfLoadingIndicatorState();
}

class _PdfLoadingIndicatorState extends State<_PdfLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: null, // indeterminate; SfPdfViewer doesn't expose byte progress
                  strokeWidth: 4,
                  color: appColor,
                  backgroundColor: appColor.withOpacity(0.12),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Gufungura inyandiko...",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Birashobora gutwara akanya gato",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}