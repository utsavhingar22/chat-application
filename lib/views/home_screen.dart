import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import '../controllers/message_controller.dart';
import 'users_list_tab.dart';
import 'chat_history_tab.dart';
import 'chat_screen.dart';
import 'widgets/custom_tab_switcher.dart';

class HomeScreen extends StatefulWidget {
  final UserController userController;
  final MessageController messageController;

  const HomeScreen({
    Key? key,
    required this.userController,
    required this.messageController,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  int _selectedBottomNavIndex = 0;
  final ScrollController _usersScrollController = ScrollController();
  final ScrollController _historyScrollController = ScrollController();
  final PageController _pageController = PageController();
  bool _showAppBar = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _usersScrollController.addListener(_onUsersScroll);
    _historyScrollController.addListener(_onHistoryScroll);
  }

  void _onUsersScroll() {
    if (_selectedTabIndex == 0) {
      _handleScroll(_usersScrollController);
    }
  }

  void _onHistoryScroll() {
    if (_selectedTabIndex == 1) {
      _handleScroll(_historyScrollController);
    }
  }

  void _handleScroll(ScrollController controller) {
    if (!controller.hasClients) return;
    
    final currentOffset = controller.offset;
    if (currentOffset > _lastScrollOffset && currentOffset > 100) {
      if (_showAppBar) {
        setState(() => _showAppBar = false);
      }
    } else if (currentOffset < _lastScrollOffset) {
      if (!_showAppBar) {
        setState(() => _showAppBar = true);
      }
    }
    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _usersScrollController.removeListener(_onUsersScroll);
    _historyScrollController.removeListener(_onHistoryScroll);
    _usersScrollController.dispose();
    _historyScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onUserTap(UserModel user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
          user: user,
          messageController: widget.messageController,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _onChatHistoryTap(String userId, String userName) {
    final user = widget.userController.getUserById(userId);
    if (user != null) {
      _onUserTap(user);
    } else {
      final tempUser = UserModel(id: userId, name: userName);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
            user: tempUser,
            messageController: widget.messageController,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        ),
      ).then((_) {
        setState(() {});
      });
    }
  }

  void _showAddUserDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF818CF8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_add_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Add New User',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a name to start chatting',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'User name',
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.person_outline_rounded, color: Color(0xFF6366F1), size: 20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                autofocus: true,
                style: const TextStyle(fontSize: 16),
                onSubmitted: (_) {
                  if (nameController.text.trim().isNotEmpty) {
                    widget.userController.addUser(nameController.text.trim());
                    Navigator.pop(context);
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'User added: ${nameController.text.trim()}',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        backgroundColor: const Color(0xFF6366F1),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty) {
                        widget.userController.addUser(nameController.text.trim());
                        Navigator.pop(context);
                        HapticFeedback.mediumImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'User added: ${nameController.text.trim()}',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            backgroundColor: const Color(0xFF6366F1),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text('Add User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _showAppBar
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              title: const Text(
                'Messages',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.8,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(85),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomTabSwitcher(
                    selectedIndex: _selectedTabIndex,
                    onTabChanged: _onTabChanged,
                    tabs: const ['Users', 'Chat History'],
                  ),
                ),
              ),
            )
          : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedTabIndex = index;
            _showAppBar = true;
          });
        },
        children: [
          UsersListTab(
            userController: widget.userController,
            onUserTap: _onUserTap,
            scrollController: _usersScrollController,
          ),
          ChatHistoryTab(
            messageController: widget.messageController,
            onChatTap: _onChatHistoryTap,
            scrollController: _historyScrollController,
          ),
        ],
      ),
      floatingActionButton: _selectedTabIndex == 0 && _selectedBottomNavIndex == 0
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: FloatingActionButton.extended(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  _showAddUserDialog();
                },
                backgroundColor: const Color(0xFF6366F1),
                elevation: 8,
                icon: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
                label: const Text(
                  'Add User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded, 'Home', 0),
                _buildNavItem(Icons.local_offer_outlined, Icons.local_offer, 'Offers', 1),
                _buildNavItem(Icons.settings_outlined, Icons.settings, 'Settings', 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _selectedBottomNavIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() {
              _selectedBottomNavIndex = index;
            });
            if (index == 1) {
              Navigator.pushNamed(context, '/offers');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/settings');
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6366F1).withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isSelected ? activeIcon : icon,
                      key: ValueKey(isSelected),
                      color: isSelected ? const Color(0xFF6366F1) : Colors.grey[500],
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? const Color(0xFF6366F1) : Colors.grey[600],
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
