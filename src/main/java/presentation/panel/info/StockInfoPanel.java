package presentation.panel.info;

import bl.SelfSelectStock;
import blservice.SelfSelectStockService;
import org.jfree.chart.ChartPanel;
import po.StockPO;
import presentation.UltraSwing.UltraButton;
import presentation.frame.MainFrame;
import presentation.panel.StockKLine_Daily;
import presentation.panel.StockKLines;
import vo.StockVO;

import javax.swing.*;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;

/**
 * Created by 宋益明 on 16-3-8.
 * <p>
 * 股票详细信息面板
 * 通过表格展现股票的所有信息
 * 通过图表展示数据变化情况
 */
public class StockInfoPanel extends InfoPanel {

    /**
     * 关注按钮
     */
    private JButton btnFollow;

    /**
     * 详细数据按钮
     */
    private UltraButton btnInfo;

    /**
     * 当前信息面板
     */
    private JPanel currentInfo;

    /**
     * k-线图面板
     */
    private JTabbedPane k_line;

    /**
     * 持有的股票对象
     */
    private StockPO stock;

    /**
     * 股票ID
     */
    private String stockID;

    /**
     * 刷新界面标记，界面发生切换后，停止刷新
     */
    private boolean updateFlag;

    public StockInfoPanel(JPanel parent, StockPO stock) {
        super(parent);

        this.stock = stock;
        this.stockID = stock.getId();

        createUIComponents();
        addListeners();
    }

    @Override
    protected void init() {
        super.init();

        updateFlag = true;

        update();
    }

    @Override
    protected void createUIComponents() {
        super.createUIComponents();

        btnFollow = new JButton("关注");
        btnInfo = new UltraButton("详细数据");

        try {
            currentInfo = new StockCurrentInfoPanel(stockID);
            k_line = new StockKLines(stockID).getjTabbedPane();
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(MainFrame.getMainFrame(), "请检查网络连接！");
        }

        add(btnFollow);
        add(currentInfo);
        add(k_line);
    }

    @Override
    protected void addListeners() {
        super.addListeners();

        addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                assignment();
            }
        });

        btnFollow.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                follow(stockID);
            }
        });

        btnInfo.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                MainFrame.getMainFrame().addOperationPanel(
                        new DetailedInfoPanel(StockInfoPanel.this, stockID));
            }
        });
    }

    /**
     * 界面大小发生变化时，重新布局所有组件
     */
    private void assignment() {
        super.assignmentValue();

        btnFollow.setBounds(PANEL_WIDTH - MARGIN - BUTTON_WIDTH,
                MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT);
        btnInfo.setBounds(btnFollow.getX() - BUTTON_WIDTH * 2, btnFollow.getY(),
                BUTTON_WIDTH * 3 / 2, BUTTON_HEIGHT);
        currentInfo.setBounds(MARGIN, btnFollow.getY() + BUTTON_HEIGHT + PADDING / 4,
                PANEL_WIDTH - MARGIN * 2, LocationValue.INFO_PANEL_HEIGHT);
        k_line.setBounds(MARGIN, currentInfo.getY() + currentInfo.getHeight() + PADDING / 4,
                PANEL_WIDTH - MARGIN * 2,
                PANEL_HEIGHT - (currentInfo.getY() + currentInfo.getHeight() + PADDING / 4) - PADDING);

        revalidate();
        repaint();
    }

    /**
     * 关注股票
     *
     * @param name 股票名称(代码)
     */
    private void follow(String name) {
        try {
            SelfSelectStockService selfSelect = new SelfSelectStock();
            boolean exist = selfSelect.addStock(name);

            if (exist) {
                JOptionPane.showMessageDialog(this, "添加成功!");
            } else {
                JOptionPane.showMessageDialog(this, "您添加的股票已在关注列表中");
            }
        } catch (IOException e) {
            JOptionPane.showMessageDialog(this, "呀!出错啦...");
        }
    }

    /**
     * 固定时间间隔刷新面板
     */
    private void update() {
        new Thread() {
            @Override
            public void run() {
                try {
                    while (updateFlag) {
                        Thread.sleep(100);
                        assignment();
                    }
                } catch (Exception e) {}
            }
        }.start();
    }

//    /**
//     * 股票详细数据面板
//     */
//    private class DetailedInfoPanel extends InfoPanel {
//
//        /**
//         * 关注按钮
//         * 无法直接复用StockInfoPanel中的关注按钮
//         * 只能再重新写一遍了。。。。。
//         */
//        private JButton follow;
//
//        DetailedInfoPanel(JPanel parent, StockPO stock) {
//            super(parent);
//
//            createUIComponents();
//            addListeners();
//
//            displayInfo(stock);
//        }
//
//        @Override
//        protected void createUIComponents() {
//            super.createUIComponents();
//
//            follow = new JButton("关注");
//            add(follow);
//        }
//
//        @Override
//        protected void addListeners() {
//            super.addListeners();
//
//            follow.addMouseListener(new MouseAdapter() {
//                @Override
//                public void mouseClicked(MouseEvent e) {
//                    follow(stockID);
//                }
//            });
//
//            addComponentListener(new ComponentAdapter() {
//                @Override
//                public void componentResized(ComponentEvent e) {
//                    follow.setBounds(PANEL_WIDTH - MARGIN - BUTTON_WIDTH,
//                            MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT);
//
//                    revalidate();
//                    repaint();
//                }
//            });
//        }
//
//        private void displayInfo(StockPO stock) {
//            try {
//                createTable(new StockVO(stock));
//            } catch (IOException e) {
//                JOptionPane.showMessageDialog(StockInfoPanel.this, "请检查网络连接！");
//            }
//        }
//    }
}
