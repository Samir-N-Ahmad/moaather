import 'package:flutter/material.dart';
import 'package:moaather/src/sidebar/widgets/side_bar_tab_widget.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SidebarWidgetState();
  }
}

class _SidebarWidgetState extends State<SideBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorScheme.of(context).onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Title +"),
          SideBarTabWidget(
            isActive: true,
            text: "Posts",
            icon: Icons.featured_play_list_outlined,
            onClick: () => {},
          ),
          SideBarTabWidget(
            text: "History",
            icon: Icons.history,
            onClick: () => {},
          ),
          SideBarTabWidget(text: "Media", icon: Icons.image, onClick: () => {}),
          Expanded(child: Container()),
          SideBarTabWidget(
            isHighlighted: true,
            text: "New Post",
            icon: Icons.post_add,
            onClick: () => {},
          ),
        ],
      ),
    );
  }
}
